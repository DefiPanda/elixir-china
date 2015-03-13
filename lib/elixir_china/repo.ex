defmodule Repo do
  use Ecto.Repo, 
    otp_app: :elixir_china, 
    adapter: Ecto.Adapters.Postgres
end
