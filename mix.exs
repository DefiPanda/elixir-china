defmodule ElixirChina.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_china,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: { ElixirChina, [] },
      applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext, :bcrypt, :phoenix_ecto, :postgrex]
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 1.1.4"},
      {:phoenix_ecto, "~> 2.0"},
      {:phoenix_html, "~> 2.4"},
      {:phoenix_live_reload, "~> 1.0.1", only: :dev},
      {:cowboy, "~> 1.0.0"},
      {:postgrex, ">= 0.0.0"},
      {:scrivener, "~> 1.1"},
      {:gettext, "~> 0.9"},
      {:bcrypt, github: "chef/erlang-bcrypt"},
      {:uuid, github: "okeuday/uuid"}
    ]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
