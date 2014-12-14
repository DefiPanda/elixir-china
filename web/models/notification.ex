defmodule ElixirChina.Notification do
  use Ecto.Model

  schema "notifications" do
  	field :type, :integer
    belongs_to :post, ElixirChina.Post
    belongs_to :user, ElixirChina.User
  end
end