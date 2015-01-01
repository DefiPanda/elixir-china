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

  def create(conn, %{"user" => %{"email" => email, "name" => name, "password" => password}}) do
    user = %User{email: email, name: name, admin: false, password: password}

    case User.validate(user) do
      [] ->
      	user = %{user | :password => to_string User.encrypt_password(user.password)}
        user = Repo.insert(user)
        conn = put_session conn, :user_id, user.id
        conn = put_session conn, :current_user, user
        render conn, "show.html", user: user, user_id: get_session(conn, :user_id)
      errors ->
        render conn, "new.html", user: user, errors: errors, user_id: get_session(conn, :user_id)
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
    user = %{user | password: params["password"]}

    case User.validate_password(user.password) do
      [] ->
        user = %{user | :password => to_string User.encrypt_password(user.password)}
        Repo.update(user)
        render conn, "show.html", user: user, user_id: get_session(conn, :user_id)
      errors ->
        render conn, "edit.html", user: user, errors: errors, user_id: get_session(conn, :user_id)
    end
  end
end