defmodule Repo.Migrations.AddCommentTime do
  use Ecto.Migration

  def up do
    "ALTER TABLE comments ADD time timestamp"
  end

  def down do
    "ALTER TABLE comments DROP time"
  end
end
