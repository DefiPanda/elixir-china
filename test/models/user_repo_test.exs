defmodule ElixirChina.UserRepoTest do
  use ElixirChina.ModelCase

  alias ElixirChina.User

  test "count/1 returns count of querying users" do
    assert Repo.one(User.count) == 0

    insert_user
    assert Repo.one(User.count) == 1

    insert_user(%{email: "jose@elixir.com", name: "jose"})
    assert Repo.one(User.count) == 2

    query = from c in User, where: [email: "jose@elixir.com"]
    assert Repo.one(User.count(query)) == 1
  end

  test "leading/1 returns leading users" do
    assert Repo.all(User.leading) == []

    %User{id: user_id1} = insert_user
    assert [%User{id: ^user_id1}] = Repo.all(User.leading)

    %User{id: user_id2} = insert_user(%{email: "jose@elixir.com", name: "jose", score: 10})
    assert [%User{id: ^user_id2}, %User{id: ^user_id1}] = Repo.all(User.leading)

    assert [%User{id: ^user_id2}] = Repo.all(User.leading(1))
  end
end
