defmodule Repo.Migrations.AddCategoryRecord do
  use Ecto.Migration

  def up do
    "INSERT INTO categories VALUES (5, '视频')"
  end
  
  def down do
    "DELETE FROM categories WHERE id = 5"
  end
end
