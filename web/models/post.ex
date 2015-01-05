defmodule ElixirChina.Post do
  use Ecto.Model

  validate post,
     content: present(),
     title: present(),
     category_id: present()

  schema "posts" do
    field :title, :string
    field :content, :string
    field :time, :datetime
    field :update_time, :datetime
    belongs_to :user, ElixirChina.User
    belongs_to :category, ElixirChina.Category
    has_many :comments, ElixirChina.Comment
    field :comments_count, :integer
  end
end
