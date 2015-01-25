defmodule ElixirChina.User do
  use Ecto.Model

  schema "users" do
    field :email
    field :name
    field :password
    field :admin, :boolean
    field :score, :integer, default: 0
    has_many :comments, ElixirChina.Comment
    has_many :posts, ElixirChina.Post
    has_many :notifications, ElixirChina.Notification
  end

  @bad_name_list [
    "root", "admin", "administrator", "post", "bot", "robot", "master", "webmaster",
    "account", "people", "user", "users", "project", "projects",
    "search", "action", "favorite", "like", "love", "none", "team", 
    "teams", "group", "groups", "organization", "organizations", 
    "package", "packages", "help",  "docs", "document", "documentation", 
    "blog",  "forum", "forums", "static", "assets", "repository",
    "public", "private"
  ]

  def changeset(user, :create, params) do
    params
    |> cast(user, ~w(name email password))
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 4)
    |> validate_length(:password, min: 6)
    |> validate_exclusion(:name, @bad_name_list)
    |> validate_unique(:name, on: Repo)
    |> validate_unique(:email, on: Repo)
    |> put_change(:password, encrypt_password(params["password"]))
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
      hashed_password |> List.to_string
    end
  end
end