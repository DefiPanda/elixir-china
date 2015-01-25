defmodule ElixirChina.UserController do
  import ElixirChina.ControllerUtils
  use Phoenix.Controller
  alias ElixirChina.User

  plug :action

  def index(conn, _params) do
    redirect conn, "/"
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(User, String.to_integer(id)) do
      user when is_map(user) ->
        render conn, "show.html", user: user, user_id: get_session(conn, :user_id)
      _ ->
        unauthorized conn
    end
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    changeset = User.changeset %User{}, :create, params["user"]

    if changeset.valid? do
      user = Repo.insert(changeset)
      conn = put_session conn, :user_id, user.id
      render conn, "show.html", user: user, user_id: user.id
    else
      render conn, "new.html", errors: changeset.errors
    end
  end

  def edit(conn, %{"id" => id}) do
    user_id = get_user_id(conn)
    if user_id != String.to_integer(id) do
      unauthorized conn
    end
    case Repo.get(User, String.to_integer(id)) do
      user when is_map(user) ->
        render conn, "edit.html", user: user, user_id: get_session(conn, :user_id)
      _ ->
        unauthorized conn
    end
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Repo.get(User, String.to_integer(id))
    user = %{user | password_digest: params["password"]}

    case User.validate_password(user.password) do
      nil ->
        user = %{user | :password_digest => to_string User.encrypt_password(user.password)}
        Repo.update(user)
        render conn, "show.html", user: user, user_id: get_session(conn, :user_id)
      errors ->
        render conn, "edit.html", user: user, errors: errors, user_id: get_session(conn, :user_id)
    end
  end
end
