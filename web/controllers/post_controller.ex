defmodule ElixirChina.PostController do
  import Ecto.Query
  import ElixirChina.ControllerUtils
  use ElixirChina.Web, :controller
  alias ElixirChina.Router.Helpers
  alias ElixirChina.Post
  alias ElixirChina.Comment
  alias ElixirChina.Notification
  alias ElixirChina.Category
  alias ElixirChina.User

  plug :action

  def index(conn, %{"user_id" => user_id}) do
    render conn, "index.html",
          posts: Repo.all(from p in Post, where: p.user_id == ^String.to_integer(user_id), order_by: [{:desc, p.time}], preload: :category),
          user: Repo.get(User, String.to_integer(user_id)),
          user_id: get_session(conn, :user_id)
  end

  def index(conn, _params) do
    redirect conn, to: "/"
  end

  def show(conn, %{"id" => id}) do
    case get_loaded_post(String.to_integer(id)) do
      post when is_map(post) ->
        user_id = get_session(conn, :user_id)
        comments = get_comments_with_loaded_user(String.to_integer(id))
        render conn, "show.html", post: post, comments: comments, user_id: user_id, is_admin: is_admin(user_id)
      _ ->
        unauthorized conn
    end
  end

  def new(conn, _params) do
    render conn, "new.html", user_id: get_session(conn, :user_id), post: %Post{}, categories: Repo.all(Category)
  end

  def create(conn, %{"post" => %{"title" => title, "content" => content, "category_id" => category_id}}) do
    user_id = get_user_id(conn)
    # utc = utc()
    # update_time is initialized here and will only be changed when a comment is to be made or deleted.
    post = %{title: title, content: content, user_id: user_id,
                category_id: String.to_integer(category_id)}

    changeset = Post.changeset(%Post{}, post)

    if changeset.valid? do
      post = Repo.insert(changeset)
      increment_score(Repo.get(User, user_id), 10)
      redirect conn, to: Helpers.post_path(conn, :show, post.id)
    else
        render conn, "new.html", post: post, errors: changeset.errors, user_id: get_session(conn, :user_id), categories: Repo.all(Category)
    end
  end

  def edit(conn, %{"id" => id}) do
    post = validate_and_get_post(conn, id, false)
    case post do
      post when is_map(post) ->
        render conn, "edit.html", post: post, categories: Repo.all(Category), user_id: get_session(conn, :user_id)
      _ ->
        unauthorized conn
    end
  end

  def update(conn, %{"id" => id, "post" => params}) do
    post = validate_and_get_post(conn, id, false)
    update_params = %{title: params["title"],
                    content: params["content"],
                category_id: String.to_integer(params["category_id"])}

    changeset = Post.changeset(post, update_params)
    if changeset.valid? do
      Repo.update(changeset)
      json conn, %{location: Helpers.post_path(conn, :show, post.id)}
    else
      json conn, errors: changeset.errors
    end
  end

  def delete(conn, %{"id" => id}) do
    post = validate_and_get_post(conn, id, true)
    case post do
      post when is_map(post) ->
        (from n in Notification, where: n.post_id == ^String.to_integer(id)) |> Repo.delete_all
        (from comment in Comment, where: comment.post_id == ^String.to_integer(id)) |> Repo.delete_all
        increment_score(Repo.get(User, post.user_id), -10)
        Repo.delete(post)
        json conn, %{location: "/"}
      _ ->
        unauthorized conn
    end
  end

  defp get_loaded_post(id) do
    query = from(c in Post, where: c.id == ^id, preload: [:user, :category])
    List.first(Repo.all(query))
  end

  defp get_comments_with_loaded_user(id) do
    query = from(c in Comment, where: c.post_id == ^id, order_by: c.time, preload: :user)
    Repo.all(query)
  end

  # Admin is only allowed to delete, but not edit, a post
  defp validate_and_get_post(conn, id, admin_ok) do
    user_id = get_user_id(conn)
    post = Repo.get(Post, String.to_integer(id))
    if user_id == post.user_id or (admin_ok and is_admin(user_id)) do
      post
    else
      unauthorized conn
    end
  end

  defp is_admin(user_id) do
    unless is_nil(user_id) do
      user = Repo.one(from u in User, where: u.id == ^user_id)
      is_map(user) and user.admin
    end
  end
end
