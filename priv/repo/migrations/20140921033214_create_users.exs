defmodule Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS users(id serial primary key, name text unique , email text unique, admin boolean DEFAULT FALSE, password text)"
  end

  def down do
    "DROP TABLE users"
  end
end
