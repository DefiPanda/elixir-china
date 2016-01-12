use Mix.Config

config :elixir_china, ElixirChina.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

config :elixir_china, ElixirChina.Repo,
  pool: Ecto.Adapters.SQL.Sandbox

# Print only warnings and errors during test
config :logger, level: :warn

# Configures database
config :elixir_china, ElixirChina.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "elixir_china_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
