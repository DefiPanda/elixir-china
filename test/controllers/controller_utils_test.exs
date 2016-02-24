defmodule ElixirChina.ControllerUtilsTest do
  use ExUnit.Case
  use Plug.Test
  use ElixirChina.ModelCase

  alias ElixirChina.{ControllerUtils}
  alias Plug.Conn

  import ElixirChina.TestHelpers

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
    {:ok, conn: conn, user: user}
  end

  test "get_user_id returns the user_id if it is set in session", %{conn: conn, user: user} do
    conn = Conn.put_session(conn, :user_id, user.id)
    assert ControllerUtils.get_user_id(conn) == user.id
  end
end