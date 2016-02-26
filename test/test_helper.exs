ExUnit.start(exclude: [:skip])

Mix.Task.run "ecto.create", ~w(-r ElixirChina.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ElixirChina.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(ElixirChina.Repo)
