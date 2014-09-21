defmodule ElixirChina.PostController do
  use Phoenix.Controller
  alias ElixirChina.Router
  alias ElixirChina.Post

  def index(conn, _params) do
    render conn, "index", posts: Repo.all(Post)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Post, String.to_integer(id)) do
      post when is_map(post) ->
        render conn, "show", post: post
      _ ->
        redirect conn, ElixirChina.Router.page_path(page: "unauthorized")
    end
  end

  def new(conn, _params) do
    render conn, "new"
  end

  def create(conn, %{"post" => %{"content" => content}}) do
    post = %Post{content: content}

    case Post.validate(post) do
      [] ->
        post = Repo.insert(post)
        render conn, "show", post: post
      errors ->
        render conn, "new", post: post, errors: errors
    end
  end

  def edit(conn, %{"id" => id}) do
    case Repo.get(Post, String.to_integer(id)) do
      post when is_map(post) ->
        render conn, "edit", post: post
      _ ->
        redirect conn, ElixirChina.Router.page_path("unauthorized")
    end
  end

  def update(conn, %{"id" => id, "post" => params}) do
    post = Repo.get(Post, String.to_integer(id))
    post = %{post | content: params["content"]}

    case Post.validate(post) do
      [] ->
        Repo.update(post)
        json conn, 201, JSON.encode!(%{location: ElixirChina.Router.post_path(:show, post.id)})
      errors ->
        json conn, errors: errors
    end
  end

  def destroy(conn, %{"id" => id}) do
    post = Repo.get(Post, String.to_integer(id))
    case post do
      post when is_map(post) ->
        Repo.delete(post)
        json conn, 200, JSON.encode!(%{location: ElixirChina.Router.post_path(:index)})
      _ ->
        redirect conn, ElixirChina.Router.page_path("unauthorized")
    end
  end
end