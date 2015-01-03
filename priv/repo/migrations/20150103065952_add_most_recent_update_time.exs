defmodule Repo.Migrations.AddMostRecentUpdateTime do
  use Ecto.Migration

  def up do
    "ALTER TABLE posts ADD update_time timestamp DEFAULT '2014-12-21 00:00:00'"
  end

  def down do
    "ALTER TABLE posts DROP update_time"
  end
end
