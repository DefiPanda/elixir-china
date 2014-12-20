defmodule Repo.Migrations.AddPostTime do
  use Ecto.Migration

  def up do
    "ALTER TABLE posts ADD time timestamp"
  end

  def down do
    "ALTER TABLE posts DROP time"
  end
end
