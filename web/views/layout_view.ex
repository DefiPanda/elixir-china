defmodule ElixirChina.LayoutView do
  use ElixirChina.Web, :view

  def show_leaderboard?(conn) do
    Dict.get(conn.assigns, :show_leaderboard)
  end
end
