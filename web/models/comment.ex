defmodule ElixirChina.Comment do
  use Ecto.Model
  alias Ecto.DateTime

  schema "comments" do
    field :content, :string
    timestamps
    belongs_to :post, ElixirChina.Post
    belongs_to :user, ElixirChina.User
  end

  def changeset(comment, :create, params) do
    params
    |> cast(comment, ~w(content))
    |> validate_length(:content, min: 5)
    |> put_change(:inserted_at, DateTime.utc)
    |> put_change(:updated_at, DateTime.utc)
  end

  def changeset(comment, :update, params) do
    params
    |> cast(comment, ~w(content))
    |> validate_length(:content, min: 5)
    |> put_change(:updated_at, DateTime.utc)
  end
end