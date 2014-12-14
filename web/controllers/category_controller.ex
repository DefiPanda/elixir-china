defmodule ElixirChina.CategoryController do
  import Ecto.Query
  use Phoenix.Controller
  alias ElixirChina.Post
  alias ElixirChina.Category

  def index(conn, _params) do
    render conn, "index", categories: get_categories(),
                      posts: Repo.all(from c in Post, where: true, preload: :user),
                      user_id: get_session(conn, :user_id)
  end

  def show(conn, %{"id" => id}) do
	  query = from p in Post, where: p.category_id == ^String.to_integer(id), preload: :user
    render conn, "show", categories: get_categories(),
                      posts: Repo.all(query),
                      category: String.to_integer(id),
                      user_id: get_session(conn, :user_id)
  end

  defp get_categories() do
    categories = Repo.all(Category)
    for category <- categories, do: %{name: category.name,
        id: category.id}
  end

  defp get_posts(id) do
    query = from p in Post, where: p.category_id == ^String.to_integer(id), preload: :user
    render conn, "show", posts: Repo.all(query), category: Repo.get(Category, String.to_integer(id))
  end
end