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

  @optional_fields ~w(update_time comments_count)a
  @required_fields ~w(content title category_id user_id)a
  @allowed_fields @required_fields ++ @optional_fields

  def changeset(post, params \\ %{}) do
    post
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end

  def count(query \\ __MODULE__) do
    from p in query, select: count(p.id)
  end

  def recent(query \\ __MODULE__) do
    from p in query, order_by: [desc: p.update_time]
  end

  def by_category_id(query \\ __MODULE__, category_id) do
    from p in query, where: p.category_id == ^category_id
  end

  def summary(post) do
    post.content
    # image
    |> String.replace(~r/\!\[.*?\]\(.*?\)/, "")
    # link
    |> String.replace(~r/\[(.*?)\]\(.*?\)/, "\\1")
    # leading formats
    |> String.replace(~r/(^|\n)(>\s*|#+\s*|\*\s+)/, "\\1")
    |> String.slice(0..99)
    |> String.trim
  end
end
