defmodule ElixirChina.UserController do
  use ElixirChina.Web, :controller

  import ElixirChina.ControllerUtils
  alias ElixirChina.User

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
    render conn, "new.html", user_id: nil, errors: nil
  end

  def create(conn, %{"user" => %{"email" => email, "name" => name, "password" => password}}) do
    user = %{email: email, name: name, admin: false, password: password}
    changeset = Ecto.Changeset.add_error(User.changeset(%User{}, user), :name, "网站暂时不支持注册")
    render conn, "new.html", user: user, errors: changeset.errors, user_id: get_session(conn, :user_id)
  end

  def edit(conn, %{"id" => id}) do
    user_id = get_user_id(conn)
    if user_id != String.to_integer(id) do
      unauthorized conn
    end
    case Repo.get(User, String.to_integer(id)) do
      user when is_map(user) ->
        render conn, "edit.html", user: user, user_id: get_session(conn, :user_id), errors: nil
      _ ->
        unauthorized conn
    end
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Repo.get(User, String.to_integer(id))
    changeset = User.changeset(user, params)

    if changeset.valid? do
      changeset = Ecto.Changeset.put_change(changeset, :password, params["password"] |> User.encrypt_password |> to_string)
      Repo.update(changeset)
      render conn, "show.html", user: user, user_id: get_session(conn, :user_id)
    else
      render conn, "edit.html", user: user, errors: changeset.errors, user_id: get_session(conn, :user_id)
    end
  end
end
