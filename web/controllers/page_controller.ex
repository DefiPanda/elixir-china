defmodule ElixirChina.PageController do
  use Phoenix.Controller

  plug :action
  
  def show(conn, %{"page" => "unauthorized"}) do
    conn
    |> put_layout(false)
    |> render "unauthorized.html"
  end

  def error(conn, {:error, ElixirChina.Errors.Unauthorized}) do
    redirect conn, "/login"
  end
end
