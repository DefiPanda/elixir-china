defmodule ElixirChina.Comment do
  use Ecto.Model

  validate comment,
     content: present()

  schema "comments" do
    field :content, :string
    field :time, :datetime
    belongs_to :post, ElixirChina.Post
    belongs_to :user, ElixirChina.User
  end
end