defmodule ElixirChina.SessionController do
  import Ecto.Query
  use Phoenix.Controller
  alias ElixirChina.Router

  def new(conn, _params) do
    render conn, "new"
  end

  def create(conn, %{"user" => %{"name" => name, "password" => password}}) do
    login(conn, name, password)
  end

  defp login(conn, name, password) do
    query = from u in User, where: u.name == ^name
    users = Repo.all query

    case length(users) > 0 do
      true ->
        user = users |> hd
        if User.valid_password?(user, password) do
          # TODO: Add session validation logic
          redirect conn, Router.post_path(:index)
        else
          render conn, "new", errors: [{"密码", "错误"}]
        end
      false ->
        render conn, "new", errors: [{"用户名", "不存在"}]
    end
  end

  def destroy(conn, _params) do
  	# TODO: Add session validation logic
    render conn, "new"
  end
end