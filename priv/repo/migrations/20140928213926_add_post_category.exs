defmodule Repo.Migrations.CreatePostCategory do
  use Ecto.Migration

  def up do
    ["CREATE TABLE categories(id serial primary key, name text unique)",
    "INSERT INTO categories VALUES (1, '学习资料')",
    "INSERT INTO categories VALUES (2, '问答')",
    "INSERT INTO categories VALUES (3, '招聘')",
    "INSERT INTO categories VALUES (4, '灌水乐园')",
    "ALTER TABLE posts ADD category_id integer REFERENCES categories(id);"]
  end

  def down do
    ["ALTER TABLE posts DROP category_id",
    "DROP TABLE categories"]
  end
end