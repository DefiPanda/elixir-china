defmodule ElixirChina.Post do
  use Ecto.Model

  validate post,
     content: present(),
     title: present()

  schema "posts" do
  	field :title, :string
    field :content, :string
    belongs_to :user, ElixirChina.User
    has_many :comments, ElixirChina.Comment
  end
end