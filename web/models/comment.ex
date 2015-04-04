defmodule ElixirChina.Comment do
  use Ecto.Model

  schema "comments" do
    field :content, :string

    timestamps type: Ecto.DateTime,
        inserted_at: :time,
         updated_at: false

    belongs_to :post, ElixirChina.Post
    belongs_to :user, ElixirChina.User
  end

  def changeset(comment, params \\ nil) do
    comment
    |> cast(params, ~w(content))
  end
end