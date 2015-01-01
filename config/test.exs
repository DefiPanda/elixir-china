use Mix.Config

config :elixir_china, ElixirChina.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
  
config :elixir_china, :postgres,
  host: "localhost",
  database: "elixir_china",
  username: "postgres",
  password: "postgres"