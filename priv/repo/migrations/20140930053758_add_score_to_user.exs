defmodule Repo.Migrations.AddScoreToUser do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE users ADD score integer DEFAULT 0"
  end

  def down do
    execute "ALTER TABLE users DROP score"
  end
end