defmodule ElixirChina.SessionController do
  use ElixirChina.Web, :controller

  alias ElixirChina.{Router.Helpers, User}

  plug :set_user_id
  defp set_user_id(conn, _msg) do
    assign(conn, :user_id, nil)
  end

  def new(conn, _params) do
    render conn, "new.html"
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
          redirect conn, to: Helpers.post_path(conn, :index)
        else
          render conn, "new.html", errors: [{"密码", "错误"}]
        end
      false ->
        render conn, "new.html", errors: [{"用户名", "不存在"}]
    end
  end

  def delete(conn, _params) do
    conn = put_session conn, :user_id, nil
    conn = put_session conn, :current_user, nil
    render conn, "new.html"
  end
end
