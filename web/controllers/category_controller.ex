defmodule ElixirChina.CategoryController do
  import Ecto.Query
  use Phoenix.Controller
  alias ElixirChina.Post
  alias ElixirChina.Category

  def index(conn, _params) do
    categories = Repo.all(Category)
    render conn, "index", categories: get_categories(categories),
                      user_id: get_session(conn, :user_id)
  end

  def show(conn, %{"id" => id}) do
	query = from p in Post, where: p.category_id == ^String.to_integer(id), preload: :user
    render conn, "show", posts: Repo.all(query), category: Repo.get(Category, String.to_integer(id))
  end

  # This is a hacky and inefficient way to get top result. Need to be replaced.
  defp get_categories(categories) do
    for category <- categories, do: %{name: category.name,
        id: category.id,
    	posts: Repo.all(from p in Post, where: p.category_id == ^category.id, limit: 10, preload: [:user])}
  end
end