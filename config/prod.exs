use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, ElixirChina.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_elixir_china_key",
  session_secret: "Y7$OZ^TN9H**1EO3@VKKLSZ3VH)@SL)@VK6P@TI0(N8U_EOO+*XZKVM#G80VJRN4DURCW1IV&H"

config :logger, :console,
  level: :info,
  metadata: [:request_id]

config :elixir_china, :postgres,
  host: "localhost",
  database: "elixir_china",
  username: "postgres",
  password: "postgres"