defmodule Repo.Migrations.CreatePostCategory do
  use Ecto.Migration

  def up do
    execute "CREATE TABLE categories(id serial primary key, name text unique)"
    execute "INSERT INTO categories VALUES (1, '学习资料')"
    execute "INSERT INTO categories VALUES (2, '问答')"
    execute "INSERT INTO categories VALUES (3, '招聘')"
    execute "INSERT INTO categories VALUES (4, '灌水乐园')"
    execute "ALTER TABLE posts ADD category_id integer REFERENCES categories(id)"
  end

  def down do
    execute "ALTER TABLE posts DROP category_id"
    execute "DROP TABLE categories"
  end
end