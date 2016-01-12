defmodule ElixirChina.Post do
  use ElixirChina.Web, :model

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

  @required_fields ~w(content title category_id user_id)
  @optional_fields ~w(update_time comments_count)

  def changeset(post, params \\ nil) do
    post
    |> cast(params, @required_fields, @optional_fields)
  end

  def count(query \\ __MODULE__) do
    from p in query, select: count(p.id)
  end

  def recent(query \\ __MODULE__) do
    from p in query, order_by: [desc: p.update_time]
  end

  def by_category_id(query \\ __MODULE__, category_id) do
    from p in query, where: p.category_id == ^String.to_integer(category_id)
  end
end
