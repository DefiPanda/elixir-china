defmodule Repo do
  use Ecto.Repo, otp_app: :elixir_china, adapter: Ecto.Adapters.Postgres

  def priv do
    app_dir(:elixir_china, "priv/repo")
  end
end
