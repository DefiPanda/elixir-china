defmodule ElixirChina.TestHelpers do
  alias ElixirChina.Repo
  alias ElixirChina.User
  alias ElixirChina.Post

  @user_default_attrs %{name: "david", email: "david@elixir.com", admin: false, password: "password"}
  @post_default_attrs %{title: "Elixir is cool", content: "It's very cool.", category_id: 1, user_id: 1}

  def insert_user(attrs \\ %{}) do
    changes = Map.merge(@user_default_attrs, attrs)
    Repo.insert!(User.changeset(%User{}, changes))
  end

  # This will fail because there foreign key constraint for user_id, so you have to pass it in
  def insert_post(attrs \\ %{}) do
    changes = Map.merge(@post_default_attrs, attrs)
    Repo.insert!(Post.changeset(%Post{}, changes))
  end
end
