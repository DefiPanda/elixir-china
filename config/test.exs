use Mix.Config

config :phoenix, ElixirChina.Router,
  port: System.get_env("PORT") || 4001,
  ssl: false,
  cookies: true,
  session_key: "_elixir_china_key",
  session_secret: "Y7$OZ^TN9H**1EO3@VKKLSZ3VH)@SL)@VK6P@TI0(N8U_EOO+*XZKVM#G80VJRN4DURCW1IV&H"

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug

config :elixir_china, :postgres,
  host: "localhost",
  database: "elixir_china",
  username: "postgres",
  password: "postgres"