defmodule ElixirChina.Comment do
  use Ecto.Model

  validate comment,
     content: present()

  schema "comments" do
    field :content, :string
    belongs_to :post, ElixirChina.Post
  end
end