defmodule ElixirChina.NotificationController do
  use ElixirChina.Web, :controller

  import ElixirChina.ControllerUtils

  alias ElixirChina.Notification

  def index(conn, %{"page" => page}) do
    current_user_id = get_user_id(conn)
    paged_notifications = get_notifications_by(page, current_user_id)
    render conn, "index.html", notifications: paged_notifications.entries |> Repo.preload(:post),
                               user_id: get_session(conn, :user_id),
                               pages: paged_notifications.total_pages,
                               page: page
  end

  def index(conn, %{}) do
    index(conn, %{"page" => "1"})
  end

  def delete(conn, %{"id" => id}) do
    current_user_id = get_user_id(conn)
    notification = Repo.get_by(Notification, user_id: current_user_id, id: id)
    case notification do
      nil ->
        text conn, "none"
      notification ->
        Repo.delete notification
        text conn, "success"
    end
  end

  def delete_all(conn, _params) do
    current_user_id = get_user_id(conn)
    from(n in Notification, where: n.user_id == ^current_user_id ) |> Repo.delete_all
    text conn, "success"
  end

  defp get_notifications_by(page, user_id) do
    Notification.by_user_id(user_id)
    |> Notification.recent
    |> Repo.paginate(page: page, page_size: 20)
  end
end
