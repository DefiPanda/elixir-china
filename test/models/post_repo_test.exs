defmodule ElixirChina.PostRepoTest do
  use ElixirChina.ModelCase

  alias ElixirChina.Post
  alias ElixirChina.Repo

  test "count/1 returns count of querying posts" do
    assert Repo.one(Post.count) == 0

    user = insert_user
    insert_post(%{user_id: user.id})
    assert Repo.one(Post.count) == 1

    insert_post(%{user_id: user.id, category_id: 2})
    assert Repo.one(Post.count) == 2

    query = from p in Post, where: [category_id: 1]
    assert Repo.one(Post.count(query)) == 1
  end

  test "recent/1 returns posts ordered by update_time desc" do
    user = insert_user
    post = %Post{id: post_id} = insert_post(%{user_id: user.id})
    later_time = %{post.update_time | usec: 1}
    %Post{id: post_id} = insert_post(%{user_id: user.id, update_time: later_time})
    assert [%Post{id: post_id}, %Post{id: ^post_id}] = Post |> Post.recent |> Repo.all
    query = Post.recent(from p in Post, limit: 1)
    assert [%Post{id: post_id}] = Repo.all(query)
  end

  test "by_category_id/2 returns posts with the right category_id" do
    user = insert_user
    %Post{id: post_id} = insert_post(%{user_id: user.id})
    insert_post(%{user_id: user.id, category_id: 2})

    assert [%Post{id: ^post_id}] = Repo.all(Post.by_category_id(1))

    insert_post(%{user_id: user.id})
    query = from p in Post, limit: 1
    assert [%Post{id: ^post_id}] = query |> Post.by_category_id(1) |> Repo.all
  end
end
