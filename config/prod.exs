use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :elixir_china, ElixirChina.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT") || 80],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: "ziHerwRAx1RS4ksABZzkL3Vl9aa1RH7b80BIv3v7Pn8l0ciAmfCjmuGKJxqoVoAL"

config :logger,
  level: :info

config :elixir_china, ElixirChina.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "elixir_china",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
