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
    email = info["email"]
    name  = info["login"]

    cond do
      email && (user = Repo.get_by(User, email: email)) ->
        {:ok, user}
      email && name && Repo.get_by(User, name: name) ->
        {:ok, insert_user(email, generate_name(name))}
      email && name ->
        {:ok, insert_user(email, name)}
      true ->
        {:error, "Bad info from Github"}
    end
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
