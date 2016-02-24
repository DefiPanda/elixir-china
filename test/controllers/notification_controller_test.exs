defmodule ElixirChina.NotificationControllerTest do
  use ElixirChina.ConnCase

  test "lists all notification", %{conn: conn} do
    user = insert_user
    post = insert_post(%{user_id: user.id})
    insert_notification(%{user_id: user.id, post_id: post.id})
    conn = conn |> put_session(user.id)
    conn = get conn, notification_path(conn, :index)
    assert html_response(conn, 200)
  end
end