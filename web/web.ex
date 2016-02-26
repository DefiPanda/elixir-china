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

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias ElixirChina.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]

      import ElixirChina.Router.Helpers
      import ElixirChina.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Import all HTML functions (forms, tags, etc)
      use Phoenix.HTML

      # Import URL helpers from the router
      import ElixirChina.Router.Helpers
      import ElixirChina.ViewHelpers
      import ElixirChina.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias ElixirChina.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]
      import ElixirChina.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
