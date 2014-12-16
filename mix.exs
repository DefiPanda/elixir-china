defmodule ElixirChina.Mixfile do
  use Mix.Project

  def project do
    [ app: :elixir_china,
      version: "0.0.1",
      elixir: "~> 1.0.0",
      elixirc_paths: ["lib", "web"],
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { ElixirChina, [] },
      applications: [:phoenix, :cowboy, :logger, :postgrex, :ecto, :bcrypt]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:phoenix, "0.4.1"},
      {:cowboy, "~> 1.0.0"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "0.2.5"},
      {:bcrypt, github: "opscode/erlang-bcrypt"},
      {:uuid, github: "okeuday/uuid"}
    ]
  end
end
