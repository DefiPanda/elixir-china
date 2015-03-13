defmodule Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    execute "CREATE TABLE IF NOT EXISTS users(id serial primary key, name text unique, email text unique, admin boolean DEFAULT FALSE, password text)"
  end

  def down do
    execute "DROP TABLE users"
  end
end
