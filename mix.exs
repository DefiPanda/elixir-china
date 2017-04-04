defmodule ElixirChina.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_china,
     version: "0.0.1",
     elixir: "~> 1.1",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: { ElixirChina, [] },
      applications: [:phoenix, :phoenix_html, :phoenix_pubsub, :cowboy, :logger,
                     :postgrex, :ecto, :bcrypt, :qiniu, :oauth2]
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
      {:phoenix, "~> 1.2.1"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.0"},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0.1", only: :dev},
      {:linguist, "~> 0.1.5"},
      {:cowboy, "~> 1.0.0"},
      {:postgrex, ">= 0.0.0"},
      {:qiniu, "~> 0.3.3"},
      {:scrivener, "~> 2.0"},
      {:scrivener_ecto, "~> 1.0.2"},
      {:bcrypt, github: "chef/erlang-bcrypt"},
      {:uuid, github: "okeuday/uuid"},
      {:oauth2, "~> 0.9.0"},
    ]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
