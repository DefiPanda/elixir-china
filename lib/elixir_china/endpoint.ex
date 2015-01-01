defmodule ElixirChina.Endpoint do
  use Phoenix.Endpoint, otp_app: :elixir_china

  plug Plug.Static,
    at: "/", from: :elixir_china

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_elixir_china_key",
    signing_salt: "B6MBbJXj",
    encryption_salt: "ILCzuU6U"

  plug :router, ElixirChina.Router
end
