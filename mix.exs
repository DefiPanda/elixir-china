defmodule ElixirChina.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_china,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Type `mix help compile.app` for more information
  def application do
    [
      mod: { ElixirChina, [] },
      applications: [:phoenix, :cowboy, :logger, :postgrex, :ecto, :bcrypt]
    ]
  end

  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "0.6.0"},
      {:cowboy, "~> 1.0.0"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "0.2.5"},
      {:bcrypt, github: "opscode/erlang-bcrypt"},
      {:uuid, github: "okeuday/uuid"}
    ]
  end
end
