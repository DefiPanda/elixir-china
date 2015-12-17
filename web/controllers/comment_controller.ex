defmodule ElixirChina.CommentController do
  import Ecto.Query
  import ElixirChina.ControllerUtils
  use ElixirChina.Web, :controller
  alias ElixirChina.Router.Helpers
  alias ElixirChina.Comment
  alias ElixirChina.User
  alias ElixirChina.Post
  alias ElixirChina.Notification

  def show(conn, %{"post_id" => post_id, "id" => id}) do
    case get_comment_with_loaded_user(String.to_integer(id)) do
      comment when is_map(comment) ->
        render conn, "show", post_id: post_id, comment: comment, user_id: get_session(conn, :user_id)
      _ ->
        unauthorized conn
    end
  end

  def new(conn, %{"post_id" => post_id}) do
    render conn, "new",  post_id: post_id, user_id: get_session(conn, :user_id)
  end

  def create(conn, %{"post_id" => post_id, "comment" => params}) do
    user_id = get_user_id(conn)
    comment = %{post_id: String.to_integer(post_id), user_id: user_id,
                      content: params["content"]}

    changeset = Comment.changeset(%Comment{}, comment)
    if changeset.valid? do
      comment = Repo.insert!(changeset)
      increment_score(Repo.get(User, user_id), 1)
      post = from(p in Post, where: p.id == ^comment.post_id, preload: :user)
      |> Repo.one

      post
      |> Post.changeset(%{update_time: comment.time, comments_count: post.comments_count + 1})
      |> Repo.update
      notify_subscriber(comment.post_id, post.user_id, 0)
      notify_mentioed_users(conn, comment.post_id, comment.content)
      redirect conn, to: Helpers.post_path(conn, :show, post_id)
    else
      render conn, "new.html", comment: comment, errors: changeset.errors, user_id: get_session(conn, :user_id)
    end
  end

  def edit(conn, %{"post_id" => post_id, "id" => id}) do
    comment = validate_and_get_comment(conn, id)
    case comment do
      comment when is_map(comment) ->
        render conn, "edit.html", comment: comment, post_id: post_id, user_id: get_session(conn, :user_id)
      _ ->
        unauthorized conn
    end
  end

  def update(conn, %{"post_id" => post_id, "id" => id, "comment" => params}) do
    comment = validate_and_get_comment(conn, id)
    changeset = Comment.changeset(comment, %{content: params["content"]})

    if changeset.valid? do
      Repo.update(changeset)
      json conn, %{location: Helpers.post_path(conn, :show, post_id)}
    else
      json conn, errors: changeset.errors
    end
  end

  defp get_comment_with_loaded_user(id) do
    query = from(c in Comment, where: c.id == ^id, preload: :user)
    hd(Repo.all(query))
  end

  defp validate_and_get_comment(conn, id) do
    user_id = get_user_id(conn)
    comment = Repo.get(Comment, String.to_integer(id))
    if user_id != comment.user_id do
      unauthorized conn
    end
    comment
  end

  defp get_mentioned_user_ids(conn, text) do
    Regex.scan(~r/(?<=]\(#{Helpers.user_path(conn, :index)}\/)[0-9]*(?=\))/, text)
  end

  defp notify_mentioed_users(conn, post_id, text) do
    user_ids = get_mentioned_user_ids(conn, text)
    # MENTIONED_REPLY = 1
    for user_id <- user_ids, do: notify_subscriber(post_id, String.to_integer(user_id |> List.first), 1)
  end

  defp notify_subscriber(post_id, uid, type) do
    if Repo.all(from n in Notification, where: n.user_id == ^uid and n.post_id == ^post_id and n.type == ^type) == [] do
      notification = %Notification{post_id: post_id, user_id: uid, type: type}
      Repo.insert(notification)
    end
  end
end
