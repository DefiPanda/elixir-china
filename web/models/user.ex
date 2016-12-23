defmodule ElixirChina.User do
  use ElixirChina.Web, :model

  schema "users" do
    field :email,      :string
    field :admin,      :boolean
    field :name,       :string
    field :password,   :string
    field :score,      :integer, default: 0

    has_many :comments, ElixirChina.Comment
    has_many :posts, ElixirChina.Post
    has_many :notifications, ElixirChina.Notification
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, ~w(name email admin password score)a)
    |> validate_required(~w(name email admin password)a)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:name, name: :users_name_key)
    |> unique_constraint(:email, name: :users_email_key)
  end

  def valid_password?(record, password) do
    salt = String.slice(record.password, 0, 29)
    {:ok, hashed_password} = :bcrypt.hashpw(password, salt)
    "#{hashed_password}" == record.password
  end

  def encrypt_password(password) do
    if password != nil do
      {:ok, salt} = :bcrypt.gen_salt
      {:ok, hashed_password} = :bcrypt.hashpw(password, salt)
      hashed_password
    end
  end

  def count(query \\ __MODULE__) do
    from u in query, select: count(u.id)
  end

  @leading_size 10
  def leading(size \\ @leading_size) do
    from u in __MODULE__, order_by: [{:desc, u.score}], limit: ^size
  end
end
