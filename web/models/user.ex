defmodule ElixirChina.User do
  use Ecto.Model

  validate user,
    name: present(message: "用户名不能为空"),
    name:  has_length(min: 3, too_short: "用户名最少为3位"),
    email: present(message: "邮箱不能为空"),
    admin:  present(),
    password:  has_length(min: 6, too_short: "密码最少为6位"),
    also: validate_uniqueness

  schema "users" do
    field :email,      :string
    field :admin,       :boolean
    field :name, :string
    field :password,   :string
    field :score, :integer, default: 0
    has_many :comments, ElixirChina.Comment
    has_many :posts, ElixirChina.Post
    has_many :notifications, ElixirChina.Notification
  end

  validatep validate_uniqueness(user) do
    is_name_unique = unique(:name, user.name)
    is_email_unique = unique(:email, user.email)
    case {is_name_unique, is_email_unique} do
      {false, false} -> "用户名和邮箱已经存在"
      {false, true} -> "用户名已经存在"
      {true, false} -> "邮箱已经存在"
      _ -> []
    end
  end

  defp unique(attr, value) do
    case Repo.one(from t in __MODULE__, where: field(t, ^attr) == ^value) do
      nil -> true
      _   -> false
    end
  end

  def validate_password(password) do
    case String.length(password) < 6 do
      true -> [{:password, "must be longer than 6 characters"}]
      _ -> []
    end
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
end