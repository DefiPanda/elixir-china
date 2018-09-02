defmodule ElixirChina.LayoutView do
  use ElixirChina.Web, :view

  @title "ElixirChina"
  @summary "ElixirChina 是中国人学习和交流 Elixir 语言的乐园。"

  def show_statics?(conn) do
    Dict.get(conn.assigns, :show_statics)
  end

  def show_social_login?(conn) do
    Map.get(conn.assigns, :show_social_login)
  end

  def page_title(assigns) do
    if assigns[:page_title] do
      assigns[:page_title] <> " - " <> @title
    else
      @title
    end
  end

  def page_summary(assigns) do
    if assigns[:page_summary], do: assigns[:page_summary], else: @summary
  end
end
