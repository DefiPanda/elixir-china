defmodule ElixirChina.PostController do
  import Ecto.Query
  import ElixirChina.ControllerUtils
  use Phoenix.Controller
  alias ElixirChina.Router
  alias ElixirChina.Post
  alias ElixirChina.Comment

  def index(conn, _params) do
    render conn, "index", posts: Repo.all(from c in Post, where: true, preload: :user), 
                          user_id: get_session(conn, :user_id)
  end

  def show(conn, %{"id" => id}) do
    case get_post_with_loaded_user(String.to_integer(id)) do
      post when is_map(post) ->
        comments = get_comments_with_loaded_user(String.to_integer(id))
        render conn, "show", post: post, comments: comments, user_id: get_session(conn, :user_id)
      _ ->
        redirect conn, Router.page_path(page: "unauthorized")
    end
  end

  def new(conn, _params) do
    render conn, "new", user_id: get_session(conn, :user_id)
  end

  def create(conn, %{"post" => %{"title" => title, "content" => content}}) do
    user_id = get_user_id!(conn)
    post = %Post{title: title, content: content, user_id: user_id}

    case Post.validate(post) do
      [] ->
        post = Repo.insert(post)
        render conn, "show", post: get_post_with_loaded_user(post.id), 
                             user_id: get_session(conn, :user_id)
      errors ->
        render conn, "new", post: post, errors: errors, user_id: get_session(conn, :user_id)
    end
  end

  def edit(conn, %{"id" => id}) do
    post = validate_and_get_post!(conn, id)
    case post do
      post when is_map(post) ->
        render conn, "edit", post: post, user_id: get_session(conn, :user_id)
      _ ->
        redirect %Plug.Conn{method: :get}, Router.page_path(page: "unauthorized")
    end
  end

  def update(conn, %{"id" => id, "post" => params}) do
    post = validate_and_get_post!(conn, id)
    post = %{post | title: params["title"], content: params["content"]}

    case Post.validate(post) do
      [] ->
        Repo.update(post)
        json conn, 201, JSON.encode!(%{location: Router.post_path(:show, post.id)})
      errors ->
        json conn, errors: errors
    end
  end

  def destroy(conn, %{"id" => id}) do
    post = validate_and_get_post!(conn, id)
    case post do
      post when is_map(post) ->
        (from comment in Comment, where: comment.post_id == ^String.to_integer(id)) |> Repo.delete_all
        Repo.delete(post)
        json conn, 200, JSON.encode!(%{location: Router.post_path(:index)})
      _ ->
        redirect %Plug.Conn{method: :get}, Router.page_path(page: "unauthorized")
    end
  end

  defp get_post_with_loaded_user(id) do
    query = from(c in Post, where: c.id == ^id, preload: :user)
    hd(Repo.all(query))
  end

  defp get_comments_with_loaded_user(id) do
    query = from(c in Comment, where: c.post_id == ^id, preload: :user)
    Repo.all(query)
  end

  defp validate_and_get_post!(conn, id) do
    user_id = get_user_id!(conn)
    post = Repo.get(Post, String.to_integer(id))
    if user_id != post.user_id do
      raise ElixirChina.Errors.Unauthorized, message: "您没有权限更改此帖子"
    end
    post
  end
end