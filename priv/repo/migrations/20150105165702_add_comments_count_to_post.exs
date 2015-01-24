defmodule Repo.Migrations.AddCommentsCountToPost do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE posts ADD comments_count integer DEFAULT 0"
    execute "UPDATE posts p SET comments_count=c.cnt FROM (SELECT post_id, count(*) cnt FROM comments GROUP BY post_id) c WHERE p.id=c.post_id"
  end

  def down do
    execute "ALTER TABLE posts DROP comments_count"
  end
end
