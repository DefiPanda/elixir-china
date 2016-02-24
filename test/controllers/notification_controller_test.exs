defmodule ElixirChina.NotificationControllerTest do
  use ElixirChina.ConnCase
  alias Plug.Conn

  @session Plug.Session.init(
    store: :cookie,
    key: "_app",
    encryption_salt: "yadayada",
    signing_salt: "yadayada"
  )

  setup do
    user = insert_user
    conn =
      conn(:get, "/")
      |> Map.put(:secret_key_base, String.duplicate("abcdefgh", 8))
      |> Plug.Session.call(@session)
      |> Conn.fetch_session()
      |> Conn.put_session(:user_id, user.id)
    {:ok, conn: conn, user: user}
  end

  test "lists all notification", %{conn: conn,user: user} do
    post = insert_post(%{user_id: user.id})
    insert_notification(%{user_id: user.id, post_id: post.id})
    conn = get(conn, notification_path(conn, :index, page: 1))
    assert html_response(conn, 200)
  end
end