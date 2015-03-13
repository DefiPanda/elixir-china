defmodule Repo.Migrations.AddCommentsTimestampsFields do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE comments RENAME COLUMN time TO inserted_at;"
    execute "ALTER TABLE comments ADD updated_at timestamp DEFAULT now()"
  end

  def down do
    execute "ALTER TABLE comments RENAME COLUMN inserted_at TO time;"
    execute "ALTER TABLE comments DROP updated_at"
  end
end
