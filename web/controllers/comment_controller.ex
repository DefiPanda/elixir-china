defmodule ElixirChina.CommentController do
  import Ecto.Query
  import ElixirChina.ControllerUtils
  use Phoenix.Controller
  alias ElixirChina.Router
  alias ElixirChina.Comment

  def index(conn, %{"post_id" => post_id}) do
    render conn, "index", post_id: post_id, comments: Repo.all(Comment), user_id: get_session(conn, :user_id)
  end

  def show(conn, %{"post_id" => post_id, "id" => id}) do
    case get_comment_with_loaded_user(String.to_integer(id)) do
      comment when is_map(comment) ->
        render conn, "show", post_id: post_id, comment: comment, user_id: get_session(conn, :user_id)
      _ ->
        redirect conn, Router.page_path(page: "unauthorized")
    end
  end

  def new(conn, %{"post_id" => post_id}) do
    render conn, "new",  post_id: post_id, user_id: get_session(conn, :user_id)
  end

  def create(conn, %{"post_id" => post_id, "comment" => params}) do
    user_id = get_user_id!(conn)
    comment = %Comment{post_id: String.to_integer(post_id), user_id: user_id, content: params["content"]}

    case Comment.validate(comment) do
      [] ->
        comment = Repo.insert(comment)
        render conn, "show", comment: get_comment_with_loaded_user(comment.id), 
                             post_id: post_id, 
                             user_id: get_session(conn, :user_id)
      errors ->
        render conn, "new", comment: comment, errors: errors, user_id: get_session(conn, :user_id)
    end
  end

  def edit(conn, %{"post_id" => post_id, "id" => id}) do
    comment = validate_and_get_comment(conn, id)
    case comment do
      comment when is_map(comment) ->
        render conn, "edit", comment: comment, post_id: post_id, user_id: get_session(conn, :user_id)
      _ ->
        redirect %Plug.Conn{method: :get}, Router.page_path(page: "unauthorized")
    end
  end

  def update(conn, %{"post_id" => post_id, "id" => id, "comment" => params}) do
    comment = validate_and_get_comment(conn, id)
    comment = %{comment | content: params["content"]}
    case Comment.validate(comment) do
      [] ->
        Repo.update(comment)
        json conn, 201, JSON.encode!(%{location: Router.post_comment_path(:show, post_id, comment.id)})
      errors ->
        json conn, errors: errors
    end
  end

  def destroy(conn, %{"post_id" => post_id, "id" => id}) do
    comment = validate_and_get_comment(conn, id)
    case comment do
      comment when is_map(comment) ->
        Repo.delete(comment)
        json conn, 200, JSON.encode!(%{location: Router.post_path(:show, post_id)})
      _ ->
        redirect %Plug.Conn{method: :get}, Router.page_path(page: "unauthorized")
    end
  end

  defp get_comment_with_loaded_user(id) do
    query = from(c in Comment, where: c.id == ^id, preload: :user)
    hd(Repo.all(query))
  end

  defp validate_and_get_comment(conn, id) do
    user_id = get_user_id!(conn)
    comment = Repo.get(Comment, String.to_integer(id))
    if user_id != comment.user_id do
      raise ElixirChina.Errors.Unauthorized, message: "您没有权限更改此评论"
    end
    comment
  end
end