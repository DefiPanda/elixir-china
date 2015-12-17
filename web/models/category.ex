defmodule ElixirChina.Category do
  use Ecto.Schema

  schema "categories" do
    field :name, :string
    has_many :posts, ElixirChina.Post
  end
end
