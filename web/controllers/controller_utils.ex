defmodule ElixirChina.ControllerUtils do
  import Plug.Conn

  # A new connection must be returned
  def authenticate_user!(conn) do
    user = get_user_for_request(conn)
    if user do
      put_session conn, :current_user, user
    else
      unauthorized!(conn)
    end
  end

  def get_user_id!(conn) do
    user = get_user_for_request(conn)
    if user do
      user.id
    else
      unauthorized!(conn)
    end
  end

  def get_user_for_request(conn) do
    cond do
      get_session(conn, :user_id) ->
        user_id = get_session(conn, :user_id)
        Repo.get(User, user_id)
      true -> nil
    end
  end

  defp unauthorized!(_conn) do
    raise ElixirChina.Errors.Unauthorized, message: "请登录后继续操作"
  end
end