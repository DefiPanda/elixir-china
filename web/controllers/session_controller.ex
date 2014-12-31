defmodule ElixirChina.SessionController do
  import Ecto.Query
  use Phoenix.Controller
  alias ElixirChina.Router.Helpers, as: Router
  alias ElixirChina.User

  plug :action

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
          conn = put_session conn, :user_id, user.id
          conn = put_session conn, :current_user, user
          redirect conn, Router.post_path(:index)
        else
          render conn, "new", errors: [{"密码", "错误"}]
        end
      false ->
        render conn, "new", errors: [{"用户名", "不存在"}]
    end
  end

  def destroy(conn, _params) do
  	conn = put_session conn, :user_id, nil
    conn = put_session conn, :current_user, nil
    render conn, "new"
  end
end