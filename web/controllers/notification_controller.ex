defmodule ElixirChina.NotificationController do
  import Ecto.Query
  import ElixirChina.ControllerUtils
  use Phoenix.Controller
  alias ElixirChina.Notification
  
  plug :action

  def index(conn, %{"user_id" => user_id}) do
    current_user_id = get_user_id(conn)
    if current_user_id !=  String.to_integer(user_id) do
      redirect conn, "/"
    else
      query = from n in Notification, where: n.user_id == ^String.to_integer(user_id), preload: :post
      render conn, "index.html", notifications: Repo.all(query),
                          user_id: get_session(conn, :user_id)
    end
  end

  def destroy(conn, %{"user_id" => user_id, "id" => id}) do
    current_user_id = get_user_id(conn)
    if current_user_id !=  String.to_integer(user_id) do
      redirect conn, "/"
    else
      query = from n in Notification, where: n.id == ^String.to_integer(id), preload: :post
      notification = hd(Repo.all(query))
      post_id = notification.post.get.id
      Repo.delete(notification)
      text conn, "success"
    end
  end
end