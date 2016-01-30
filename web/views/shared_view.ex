defmodule ElixirChina.SharedView do
  use ElixirChina.Web, :view

  def datetime_string(datetime) do
    Ecto.DateTime.to_iso8601(datetime)
  end
end
