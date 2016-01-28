defmodule ElixirChina.CategoryRepoTest do
  use ElixirChina.ModelCase

  alias ElixirChina.Comment

  test "count/1 returns count of querying comments" do
    assert Repo.one(Comment.count) == 0

    user = insert_user
    post = insert_post(%{user_id: user.id})
    Repo.insert!(Comment.changeset(%Comment{}, %{content: "foo", post_id: post.id, user_id: user.id}))
    assert Repo.one(Comment.count) == 1

    Repo.insert!(Comment.changeset(%Comment{}, %{content: "bar", post_id: post.id, user_id: user.id}))
    assert Repo.one(Comment.count) == 2

    query = from c in Comment, where: [content: "foo"]
    assert Repo.one(Comment.count(query)) == 1
  end
end
