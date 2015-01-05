defmodule Repo.Migrations.AddCommentsCountToPost do
  use Ecto.Migration

  def up do
    "ALTER TABLE posts ADD comments_count integer DEFAULT 0"
  end

  def down do
    "ALTER TABLE posts DROP comments_count"
  end
end
