defmodule ElixirChina.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use ElixirChina.Web, :controller
      use ElixirChina.Web, :view

  Keep the definitions in this module short and clean,
  mostly focused on imports, uses and aliases.
  """

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import URL helpers from the router
      import ElixirChina.Router.Helpers

      # Import all HTML functions (forms, tags, etc)
      use Phoenix.HTML

      # Functions defined here are available to all other views/templates
      def avatar_url(email) do
        hash = email
          |> String.strip
          |> (fn data -> :crypto.hash(:md5, data) end).()
          |> :erlang.bitstring_to_list
          |> Enum.map(&(:io_lib.format("~2.16.0b", [&1])))
          |> List.flatten
        "https://cdn.v2ex.com/gravatar/#{hash}"
      end

      def format_errors(errors), do: format_errors(errors, [])

      defp format_errors([], acc), do: Enum.reverse acc
      defp format_errors([error|errors], acc) do
        format_errors(errors, [format_error(error)|acc])
      end

      defp format_error({key, {message, value}}) when is_atom(key) do
        Atom.to_string(key) <> " " <> String.replace(message, ~r/%{.*}/, "#{value}")
      end
      defp format_error({key, message}) when is_atom(key) do
        Atom.to_string(key) <> " " <> message
      end
    end

  end

  def controller do
    quote do
      use Phoenix.Controller

      # Alias the data repository as a convenience
      alias ElixirChina.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]

      # Import URL helpers from the router
      import ElixirChina.Router.Helpers
    end
  end

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
