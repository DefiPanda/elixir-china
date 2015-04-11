defmodule Repo.Migrations.AddNotificationType do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE notifications ADD type integer DEFAULT 0"
  end

  def down do
    execute "ALTER TABLE notifications DROP type"
  end
end
