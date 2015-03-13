defmodule ElixirChina.Post do
  use Ecto.Model
  alias Ecto.DateTime

  schema "posts" do
    field :title
    field :content
    field :comments_count, :integer, default: 0
    timestamps
    belongs_to :user, ElixirChina.User
    belongs_to :category, ElixirChina.Category
    has_many :comments, ElixirChina.Comment
  end

  def changeset(post, :create, params) do
    params
    |> cast(post, ~w(title content category_id))
    |> validate_length(:title, min: 3)
    |> validate_length(:content, min: 5)
    |> put_change(:inserted_at, DateTime.utc)
    |> put_change(:updated_at, DateTime.utc)
  end

  def changeset(post, :update, params) do
    params
    |> cast(post, ~w(title content category_id))
    |> validate_length(:title, min: 3)
    |> validate_length(:content, min: 5)
    |> put_change(:updated_at, DateTime.utc)
  end
end
