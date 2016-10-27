defmodule ElixirChina.ControllerUtils do
  import Plug.Conn
  import Phoenix.Controller
  alias ElixirChina.Repo
  alias ElixirChina.Router.Helpers
  alias ElixirChina.User

  def get_user_id(conn) do
    user = get_user_for_request(conn)
    if user do
      user.id
    else
      unauthorized(conn)
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

  def increment_score(user, amount) do
    changeset = User.changeset(user, %{score: user.score + amount})
    Repo.update(changeset)
  end

  def unauthorized(conn) do
    redirect %{conn | method: :get}, to: Helpers.page_path(conn, :show, "unauthorized")
  end
end
