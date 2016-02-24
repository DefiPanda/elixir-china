defmodule ElixirChina.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_china,
     version: "0.0.1",
     elixir: "~> 1.1",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: { ElixirChina, [] },
      applications: [:phoenix, :cowboy, :logger, :postgrex, :ecto, :bcrypt, :gettext]
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
      {:phoenix, "~> 1.1.0"},
      {:phoenix_ecto, "~> 2.0"},
      {:phoenix_html, "~> 2.3"},
      {:phoenix_live_reload, "~> 1.0.1", only: :dev},
      {:linguist, "~> 0.1.5"},
      {:cowboy, "~> 1.0.0"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 1.1.0"},
      {:scrivener, "~> 1.1"},
      {:gettext, "~> 0.9"},
      {:bcrypt, github: "chef/erlang-bcrypt"},
      {:uuid, github: "okeuday/uuid"}
    ]
  end
end
