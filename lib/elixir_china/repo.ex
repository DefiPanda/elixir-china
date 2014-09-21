defmodule Repo do
    use Ecto.Repo, adapter: Ecto.Adapters.Postgres

    def conf do
      parse_url "ecto://postgres:postgres@localhost/elixir_china"
    end

    def priv do
      app_dir(:elixir_china, "priv/repo")
    end
end