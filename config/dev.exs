use Mix.Config

config :elixir_china, ElixirChina.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true

# Enables code reloading for development
config :phoenix, :code_reloader, true

config :elixir_china, :postgres,
  host: "localhost",
  database: "elixir_china",
  username: "postgres",
  password: "postgres"