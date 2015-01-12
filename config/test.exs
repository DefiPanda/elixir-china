use Mix.Config

config :elixir_china, ElixirChina.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
  