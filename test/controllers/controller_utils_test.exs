defmodule ElixirChina.ControllerUtilsTest do
  use ElixirChina.ConnCase

  alias ElixirChina.{ControllerUtils}

  test "get_user_id returns the user_id if it is set in session", %{conn: conn} do
    user = insert_user
    conn = conn(:get, "/")
    |> put_session(user.id)
    assert ControllerUtils.get_user_id(conn) == user.id
  end
end
