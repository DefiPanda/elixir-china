defmodule ElixirChina.View do
  use Phoenix.View, root: "web/templates"

  # The quoted expression returned by this block is applied
  # to this module and all other views that use this module.
  using do
    quote do
      # Import common functionality
      import ElixirChina.I18n
      import ElixirChina.Router.Helpers

      # Use Phoenix.HTML to import all HTML functions (forms, tags, etc)
      use Phoenix.HTML

      # Common aliases
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
