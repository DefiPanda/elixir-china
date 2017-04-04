defmodule ElixirChina.AuthController do
  use ElixirChina.Web, :controller

  require Logger
  alias ElixirChina.Github
  alias ElixirChina.Repo
  alias ElixirChina.User

  def index(conn, %{"provider" => provider}) do
    with {:ok, url} <- authorize_url(provider) do
      redirect(conn, external: url)
    else
      {:error, reason} ->
        Logger.error(reason)
        redirect(conn, to: "/")
    end
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    with {:ok, client} <- get_token(provider, code),
         {:ok, user} <- get_user(provider, client) do
      conn
      |> put_session(:current_user, user)
      |> put_session(:user_id, user.id)
      |> redirect(to: "/")
    else
      {:error, reason} ->
        Logger.error(reason)
        redirect(conn, to: "/")
    end
  end

  defp authorize_url("github"),  do: {:ok, Github.authorize_url!()}
  defp authorize_url(_),         do: {:error, "没有匹配到对应的Oauth2登录方式"}

  defp get_token("github", code),   do: {:ok, Github.get_token!(code: code)}
  defp get_token(_, _),             do: {:error, "没有匹配到对应的Oauth2登录方式"}

  defp get_user("github", client) do
    with {:ok, %OAuth2.Response{body: info}} <- OAuth2.Client.get(client, "/user"),
         {:ok, user} <- find_or_creat_user(info) do
      {:ok, user}
    else
      {:error, %OAuth2.Response{status_code: 401, body: _body}} ->
        {:error, "Unauthorized token"}
      {:error, %OAuth2.Error{reason: reason}} ->
        {:error, "Error: #{inspect reason}"}
      {:error, reason} ->
        {:error, "Error: #{inspect reason}"}
    end
  end

  defp find_or_creat_user(info) do
    with {:ok, email} <- fetch_email(info),
         {:ok, name} <- fetch_name(info),
         {:ok, user} <- find_or_create_user(email, name) do
      {:ok, user}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  defp find_or_create_user(email, name) do
    with {:ok, user} <- insert_user(email, name) do
      {:ok, user}
    else
      {:error, %Ecto.Changeset{errors: [email: {"has already been taken", []}]}} ->
        {:ok, Repo.get_by(User, email: email)}
      {:error, %Ecto.Changeset{errors: [name: {"has already been taken", []}]}} ->
        find_or_create_user(email, generate_name(name))
      {:error, reason} ->
        {:error, inspect(reason)}
    end
  end

  defp insert_user(email, name) do
    %User{}
    |> User.changeset(%{email: email, name: name, admin: false, password: random_string(16)})
    |> Repo.insert
  end

  defp fetch_email(info) do
    if (email = info["email"]) do
      {:ok, email}
    else
      {:error, "Bad info from oauth server"}
    end
  end

  defp fetch_name(info) do
    if (name = info["name"]) do
      {:ok, name}
    else
      {:error, "Bad info from oauth server"}
    end
  end

  defp generate_name(name) do
    name <> "#" <> random_string(3)
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.encode64
    |> binary_part(0, length)
  end
end
