defmodule Repo.Migrations.CreateComments do
  use Ecto.Migration

  def up do
    execute "CREATE TABLE comments(id serial primary key, post_id integer references posts(id), content text, time timestamp, user_id integer references users(id))"
  end

  def down do
    execute "DROP TABLE comments"
  end
end
