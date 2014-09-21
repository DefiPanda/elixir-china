defmodule ElixirChina.Post do
  use Ecto.Model

  validate post,
     content: present(),
     title: present()

  schema "posts" do
  	field :title, :string
    field :content, :string
  end
end