use Mix.Config

config :phoenix, ElixirChina.Router,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true

# Enables code reloading for development
config :phoenix, :code_reloader, true

config :elixir_china, :postgres,
  host: "192.168.59.103",
  database: "elixir_china",
  username: "postgres",
  password: "postgres"