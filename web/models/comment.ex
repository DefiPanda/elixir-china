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

  @required_fields ~w(content post_id user_id)a

  def changeset(comment, params \\ %{}) do
    comment
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

  def count(query \\ __MODULE__) do
    from c in query, select: count(c.id)
  end
end
