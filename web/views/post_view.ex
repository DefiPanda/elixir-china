defmodule ElixirChina.PostView do
  use ElixirChina.View

  def button_text("POST"), do: "发布"
  def button_text("PATCH"), do: "更新"
end