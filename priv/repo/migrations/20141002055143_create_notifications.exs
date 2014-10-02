defmodule Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def up do
    "CREATE TABLE notifications(id serial primary key, user_id integer references users(id), post_id integer references posts(id))"
  end

  def down do
    "DROP TABLE notifications"
  end
end