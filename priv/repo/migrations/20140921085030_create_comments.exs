defmodule Repo.Migrations.CreateComments do
  use Ecto.Migration

  def up do
    "CREATE TABLE comments(id serial primary key, post_id integer references posts(id), content text, user_id integer references users(id))"
  end

  def down do
    "DROP TABLE comments"
  end
end
