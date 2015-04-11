defmodule ElixirChina.Post do
  use Ecto.Model

  schema "posts" do
    field :title, :string
    field :content, :string

    timestamps type: Ecto.DateTime,
        inserted_at: :time,
         updated_at: :update_time

    belongs_to :user, ElixirChina.User
    belongs_to :category, ElixirChina.Category
    has_many :comments, ElixirChina.Comment
    field :comments_count, :integer, default: 0
  end

  def changeset(post, params \\ nil) do
    post
    |> cast(params, ~w(content title category_id user_id), ~w(update_time comments_count))
  end
end
