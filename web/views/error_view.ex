defmodule ElixirChina.ErrorView do
  use ElixirChina.Web, :view

  def render("404.html", assigns) do
    render "not_found.html", assigns
  end

  def render("500.html", assigns) do
    render "internal_error.html", assigns
  end
end
