defmodule ElixirChina.Notification do
  use ElixirChina.Web, :model

  schema "notifications" do
    field :type, :integer
    belongs_to :post, ElixirChina.Post
    belongs_to :user, ElixirChina.User
  end

  # ecto~2.0 params \\ :invalid
  def changeset(notification, params \\ :empty) do
    notification
    |> cast(params, ~w(type post_id user_id), ~w())
  end

  def recent(query \\ __MODULE__) do
    from n in query, order_by: [desc: n.id]
  end

  def by_user_id(query \\ __MODULE__, user_id) do
    from u in query, where: u.user_id == ^user_id
  end
end
