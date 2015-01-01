defmodule ElixirChina.PostController do
  import Ecto.Query
  import Ecto.DateTime
  import ElixirChina.ControllerUtils
  use Phoenix.Controller
  alias ElixirChina.Router.Helpers
  alias ElixirChina.Post
  alias ElixirChina.Comment
  alias ElixirChina.Notification
  alias ElixirChina.Category
  alias ElixirChina.User
  
  plug :action

  def index(conn, %{"user_id" => user_id}) do
    render conn, "index.html", posts: Repo.all(from p in Post, where: p.user_id == ^String.to_integer(user_id)),
          user: Repo.get(User, String.to_integer(user_id))
  end
  
  def index(conn, _params) do
    redirect conn, to: "/"
  end

  def show(conn, %{"id" => id}) do
    case get_loaded_post(String.to_integer(id)) do
      post when is_map(post) ->
        comments = get_comments_with_loaded_user(String.to_integer(id))
        render conn, "show.html", post: post, comments: comments, user_id: get_session(conn, :user_id)
      _ ->
        unauthorized conn
    end
  end

  def new(conn, _params) do
    render conn, "new.html", user_id: get_session(conn, :user_id), categories: Repo.all(Category)
  end

  def create(conn, %{"post" => %{"title" => title, "content" => content, "category_id" => category_id}}) do
    user_id = get_user_id(conn)
    post = %Post{title: title, content: content, user_id: user_id,
                category_id: String.to_integer(category_id), time: utc()}

    case Post.validate(post) do
      [] ->
        post = Repo.insert(post)
        increment_score(Repo.get(User, user_id), 10)
        redirect conn, to: Helpers.post_path(:show, post.id)
      errors ->
        render conn, "new.html", post: post, errors: errors, user_id: get_session(conn, :user_id), categories: Repo.all(Category)
    end
  end

  def edit(conn, %{"id" => id}) do
    post = validate_and_get_post(conn, id)
    case post do
      post when is_map(post) ->
        render conn, "edit.html", post: post, categories: Repo.all(Category), user_id: get_session(conn, :user_id)
      _ ->
        unauthorized conn
    end
  end

  def update(conn, %{"id" => id, "post" => params}) do
    post = validate_and_get_post(conn, id)
    post = %{post | title: params["title"], 
                    content: params["content"], 
                    category_id: String.to_integer(params["category_id"])}

    case Post.validate(post) do
      [] ->
        Repo.update(post)
        json conn, %{location: Helpers.post_path(:show, post.id)}
      errors ->
        json conn, errors: errors
    end
  end

  def destroy(conn, %{"id" => id}) do
    post = validate_and_get_post(conn, id)
    case post do
      post when is_map(post) ->
        (from n in Notification, where: n.post_id == ^String.to_integer(id)) |> Repo.delete_all
        (from comment in Comment, where: comment.post_id == ^String.to_integer(id)) |> Repo.delete_all
        Repo.delete(post)
        increment_score(Repo.get(User, get_user_id(conn)), -10)
        json conn, %{location: "/"}
      _ ->
        unauthorized conn
    end
  end

  defp get_loaded_post(id) do
    query = from(c in Post, where: c.id == ^id, preload: [:user, :category])
    hd(Repo.all(query))
  end

  defp get_comments_with_loaded_user(id) do
    query = from(c in Comment, where: c.post_id == ^id, order_by: c.time, preload: :user)
    Repo.all(query)
  end

  defp validate_and_get_post(conn, id) do
    user_id = get_user_id(conn)
    post = Repo.get(Post, String.to_integer(id))
    if user_id != post.user_id do
      unauthorized conn
    end
    post
  end
end