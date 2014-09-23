defmodule ElixirChina.UserController do
  import Ecto.Query
  use Phoenix.Controller
  alias ElixirChina.Router

  def index(conn, _params) do
      render conn, "index", users: Repo.all(User)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(User, String.to_integer(id)) do
      user when is_map(user) ->
        render conn, "show", user: user
      _ ->
        redirect conn, Router.page_path(page: "unauthorized")
    end
  end

  def new(conn, _params) do
    render conn, "new"
  end

  def create(conn, %{"user" => %{"email" => email, "name" => name, "password" => password}}) do
    user = %User{email: email, name: name, admin: false, password: password}

    case User.validate(user) do
      [] ->
      	user = %{user | :password => to_string User.encrypt_password(user.password)}
        user = Repo.insert(user)
        render conn, "show", user: user
      errors ->
        render conn, "new", user: user, errors: errors
    end
  end

  def edit(conn, %{"id" => id}) do
    case Repo.get(User, String.to_integer(id)) do
      user when is_map(user) ->
        render conn, "edit", user: user
      _ ->
        redirect conn, Router.page_path(page: "unauthorized")
    end
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Repo.get(User, String.to_integer(id))
    user = %{user | password: params["password"]}

    case User.validate_password(user.password) do
      [] ->
        user = %{user | :password => to_string User.encrypt_password(user.password)}
        Repo.update(user)
        render conn, "show", user: user
      errors ->
        render conn, "edit", user: user, errors: errors
    end
  end

  def destroy(conn, %{"id" => id}) do
    user = Repo.get(User, String.to_integer(id))
    case user do
      user when is_map(user) ->
        Repo.delete(user)
        json conn, 200, JSON.encode!(%{location: Router.user_path(:index)})
      _ ->
        redirect conn, Router.page_path(page: "unauthorized")
    end
  end
end