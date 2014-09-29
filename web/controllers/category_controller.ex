defmodule ElixirChina.CategoryController do
	import Ecto.Query
	use Phoenix.Controller
    alias ElixirChina.Router
    alias ElixirChina.Post
    alias ElixirChina.Category

	def show(conn, %{"id" => id}) do
		query = from p in Post, where: p.category_id == ^String.to_integer(id), preload: :user
        render conn, "show", posts: Repo.all(query), category: Repo.get(Category, String.to_integer(id))
	end
end