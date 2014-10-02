defmodule ElixirChina.Notification do
  use Ecto.Model

  schema "notifications" do
    belongs_to :post, ElixirChina.Post
    belongs_to :user, ElixirChina.User
  end
end