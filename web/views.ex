defmodule ElixirChina.Views do

  defmacro __using__(_options) do
    quote do
      use Phoenix.View
      import unquote(__MODULE__)

      # This block is expanded within all views for aliases, imports, etc
      import ElixirChina.I18n
      import ElixirChina.Router.Helpers
      alias Phoenix.Controller.Flash
    end
  end

  # Functions defined here are available to all other views/templates

  def avatar_url(email) do
    hash = email 
      |> String.strip
      |> :crypto.md5
      |> :erlang.bitstring_to_list 
      |> Enum.map(&(:io_lib.format("~2.16.0b", [&1]))) 
      |> List.flatten 
    "http://cdn.v2ex.com/gravatar/#{hash}"
  end
end


