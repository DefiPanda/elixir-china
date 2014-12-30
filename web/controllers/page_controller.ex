defmodule ElixirChina.PageController do
  use Phoenix.Controller

  plug :action
  
  def show(conn, %{"page" => "unauthorized"}) do
    conn
    |> assign_layout(:none)
    |> render "unauthorized"
  end

  def error(conn, _) do
    handle_error(conn, error(conn))
  end

  defp handle_error(conn, {:error, ElixirChina.Errors.Unauthorized}) do
    redirect conn, "/login"
  end

  defp handle_error(conn, _any) do
    text conn, 500, "Something went wrong"
  end
end
