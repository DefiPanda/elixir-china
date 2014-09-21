defmodule Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def up do
    "CREATE TABLE posts(id serial primary key, content varchar(140))"
  end

  def down do
    "DROP TABLE posts"
  end
end
