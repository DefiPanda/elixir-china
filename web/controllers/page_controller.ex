defmodule ElixirChina.PageController do
  use Phoenix.Controller

  def show(conn, %{"page" => "unauthorized"}) do
    conn
    |> assign_layout(:none)
    |> render "unauthorized"
  end
end
