defmodule ElixirChina.Comment do
  use ElixirChina.Web, :model

  schema "comments" do
    field :content, :string

    timestamps type: Ecto.DateTime,
        inserted_at: :time,
         updated_at: false

    belongs_to :post, ElixirChina.Post
    belongs_to :user, ElixirChina.User
  end

  def changeset(comment, params \\ :empty) do
    comment
    |> cast(params, ~w(content post_id user_id))
  end

  def count(query \\ __MODULE__) do
    from c in query, select: count(c.id)
  end
end
