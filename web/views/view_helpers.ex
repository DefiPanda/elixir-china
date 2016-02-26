defmodule ElixirChina.ViewHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """
  use Phoenix.HTML

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(form, field) do
    if error = form.errors[field] do
      content_tag :span, translate_error(error), class: "help-block"
    end
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # Because error messages were defined within Ecto, we must
    # call the Gettext module passing our Gettext backend. We
    # also use the "errors" domain as translations are placed
    # in the errors.po file. On your own code and templates,
    # this could be written simply as:
    #
    #     dngettext "errors", "1 file", "%{count} files", count
    #
    Gettext.dngettext(ElixirChina.Gettext, "errors", msg, msg, opts[:count], opts)
  end

  def translate_error(msg) do
    Gettext.dgettext(ElixirChina.Gettext, "errors", msg)
  end

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
end
