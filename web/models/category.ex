defmodule ElixirChina.Category do
  use ElixirChina.Web, :model

  schema "categories" do
    field :name, :string
    has_many :posts, ElixirChina.Post
  end
end
