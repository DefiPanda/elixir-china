defmodule Repo.Migrations.AddScoreToUser do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD score integer DEFAULT 0"
  end

  def down do
    "ALTER TABLE users DROP score"
  end
end