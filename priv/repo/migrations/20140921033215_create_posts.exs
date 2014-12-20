defmodule Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def up do
    "CREATE TABLE posts(id serial primary key, title varchar(140), content text,
    	time timestamp, user_id integer references users(id))"
  end

  def down do
    "DROP TABLE posts"
  end
end
