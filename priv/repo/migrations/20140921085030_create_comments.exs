defmodule Repo.Migrations.CreateComments do
  use Ecto.Migration

  def up do
    "CREATE TABLE comments(id serial primary key, post_id integer references posts(id), content text)"
  end

  def down do
    "DROP TABLE comments"
  end
end
