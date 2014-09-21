defmodule ElixirChina.Post do
  use Ecto.Model

  validate post,
     content: present()

  schema "posts" do
    field :content, :string
  end
end