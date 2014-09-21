# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, ElixirChina.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_elixir_china_key",
  session_secret: "Y7$OZ^TN9H**1EO3@VKKLSZ3VH)@SL)@VK6P@TI0(N8U_EOO+*XZKVM#G80VJRN4DURCW1IV&H",
  catch_errors: true,
  debug_errors: false,
  error_controller: ElixirChina.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
