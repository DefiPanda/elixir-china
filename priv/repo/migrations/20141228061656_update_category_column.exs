defmodule Repo.Migrations.UpdateCategoryColumn do
  use Ecto.Migration

  def up do
    "UPDATE categories SET name = '新闻项目' WHERE id = 4"
  end

  def down do
    "UPDATE categories SET name = '灌水乐园' WHERE id = 4"
  end
end
