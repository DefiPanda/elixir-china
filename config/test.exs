use Mix.Config

config :phoenix, ElixirChina.Router,
  http: [port: System.get_env("PORT") || 4001],
  catch_errors: false

config :elixir_china, :postgres,
  host: "localhost",
  database: "elixir_china",
  username: "postgres",
  password: "postgres"