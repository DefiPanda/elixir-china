defmodule ElixirChina.AuthController do
  use ElixirChina.Web, :controller
  use Oauthex, [:github]

  alias ElixirChina.User

  plug Oauthex.Plugs.CodeFetcher when action in [:show]
  plug Oauthex.Plugs.InfoFetcher when action in [:new]

  def show(conn, _params) do
    url = conn.assigns[:oauthex_code_url]
    case url do
      :error -> redirect(conn, to: "/")
      _ -> redirect(conn, external: url)
    end
  end

  def new(conn, _params) do
    info = conn.assigns[:oauthex_info] || %{}

    email = info[:email]
    name  = info[:login]

    cond do
      email && (user = Repo.get_by(User, email: email)) ->
        user
      email && name && Repo.get_by(User, name: name) ->
        insert_user(email, generate_name(name))
      email && name ->
        insert_user(email, name)
      true ->
        nil
    end |> sign_in(conn)
  end

  defp sign_in(user, conn) do
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_session(:current_user, user)
    else
      conn
    end |> redirect(to: "/")
  end

  defp insert_user(email, name) do
    %User{}
    |> User.changeset(%{email: email, name: name, admin: false, password: random_string(16)})
    |> Repo.insert!
  end

  defp generate_name(name) do
    new_name = name <> "#" <> random_string(3)
    if Repo.get_by(User, name: new_name) do
      generate_name(name)
    else
      new_name
    end
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.encode64
    |> binary_part(0, length)
  end
end
