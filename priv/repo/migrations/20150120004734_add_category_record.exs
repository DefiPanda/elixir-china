defmodule Repo.Migrations.AddCategoryRecord do
  use Ecto.Migration

  def up do
    execute "INSERT INTO categories VALUES (5, '视频')"
  end
  
  def down do
    execute "DELETE FROM categories WHERE id = 5"
  end
end
