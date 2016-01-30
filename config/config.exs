# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :elixir_china, ElixirChina.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  http: [port: System.get_env("PORT")],
  secret_key_base: "ziHerwRAx1RS4ksABZzkL3Vl9aa1RH7b80BIv3v7Pn8l0ciAmfCjmuGKJxqoVoAL",
  debug_errors: false,
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: ElixirChina.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger,
  backends: [{LoggerFileBackend, :file_log}]

config :logger, :file_log,
  path: "#{Path.dirname(__DIR__)}/log/#{Mix.env}.log",
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures database
config :elixir_china, ElixirChina.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "elixir_china",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
