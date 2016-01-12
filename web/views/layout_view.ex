defmodule ElixirChina.LayoutView do
  use ElixirChina.Web, :view

  def show_statics?(conn) do
    Dict.get(conn.assigns, :show_statics)
  end
end
