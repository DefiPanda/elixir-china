use Mix.Config

config :phoenix, ElixirChina.Router,
  port: System.get_env("PORT") || 4000,
  ssl: false,
  host: "localhost",
  cookies: true,
  session_key: "_elixir_china_key",
  session_secret: "Y7$OZ^TN9H**1EO3@VKKLSZ3VH)@SL)@VK6P@TI0(N8U_EOO+*XZKVM#G80VJRN4DURCW1IV&H",
  debug_errors: true

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


