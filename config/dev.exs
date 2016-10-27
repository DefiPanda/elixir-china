use Mix.Config

config :elixir_china, ElixirChina.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Watch static and templates for browser reloading.
# *Note*: Be careful with wildcards. Larger projects
# will use higher CPU in dev as the number of files
# grow. Adjust as necessary.
config :elixir_china, ElixirChina.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Configures database
config :elixir_china, ElixirChina.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "elixir_china",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :phoenix, :stacktrace_depth, 20
