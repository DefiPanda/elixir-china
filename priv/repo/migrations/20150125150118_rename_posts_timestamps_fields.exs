defmodule Repo.Migrations.RenamePostsTimestampsFields do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE posts RENAME COLUMN time TO inserted_at;"
    execute "ALTER TABLE posts RENAME COLUMN update_time TO updated_at;"
  end

  def down do
    execute "ALTER TABLE posts RENAME COLUMN inserted_at TO time;"
    execute "ALTER TABLE posts RENAME COLUMN updated_at TO update_time;"
  end
end
