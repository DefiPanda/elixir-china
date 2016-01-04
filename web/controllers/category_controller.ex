defmodule ElixirChina.CategoryController do
  use ElixirChina.Web, :controller

  alias ElixirChina.Post
  alias ElixirChina.Comment
  alias ElixirChina.User
  alias ElixirChina.Category

  @posts_per_page 15
  @leading_users_to_display 10

  plug :show_leaderboard when action in [:index, :show]
  defp show_leaderboard(conn, _msg) do
    assign(conn, :show_leaderboard, true)
  end

  def index(conn, %{"page" => page}) do
    post_count = Repo.one(from p in Post, select: count(p.id))

    render conn, "index.html", categories: get_categories(),
                      posts: get_posts_by_page(page),
                      pages: post_count / @posts_per_page |> Float.ceil,
                      page: page,
                      post_count: post_count,
                      comment_count: Repo.one(from c in Comment, select: count(c.id)),
                      user_count: Repo.one(from u in User, select: count(u.id)),
                      leading_users: Repo.all(from u in User, order_by: [{:desc, u.score}], limit: ^@leading_users_to_display),
                      show_post: true,
                      user_id: get_session(conn, :user_id),
                      conn: conn
  end

  def index(conn, %{}) do
    index(conn, %{"page" => "1"})
  end

  def show(conn, %{"id" => id, "page" => page}) do
    render conn, "show.html", categories: get_categories(),
                      posts: get_posts_by_page_and_category(page, id),
                      category: String.to_integer(id),
                      pages: Repo.one(from p in Post, where: p.category_id == ^String.to_integer(id), select: count(p.id))
                             / @posts_per_page |> Float.ceil,
                      page: page,
                      post_count: Repo.one(from p in Post, select: count(p.id)),
                      comment_count: Repo.one(from c in Comment, select: count(c.id)),
                      user_count: Repo.one(from u in User, select: count(u.id)),
                      leading_users: Repo.all(from u in User, order_by: [{:desc, u.score}], limit: ^@leading_users_to_display),
                      show_post: true,
                      user_id: get_session(conn, :user_id)
  end

  def show(conn, %{"id" => id}) do
    show(conn, %{"id" => id, "page" => "1"})
  end

  defp get_posts_by_page(page) do
    Repo.all(from p in Post, where: true, order_by: [{:desc, p.update_time}], limit: ^@posts_per_page,
      offset: ^((String.to_integer(page) - 1) * @posts_per_page), preload: [:user, :category])
  end

  defp get_posts_by_page_and_category(page, id) do
    Repo.all(from p in Post, where: p.category_id == ^String.to_integer(id), order_by: [{:desc, p.update_time}],
      limit: ^@posts_per_page, offset: ^((String.to_integer(page) - 1) * @posts_per_page), preload: [:user, :category])
  end

  defp get_categories() do
    categories = Repo.all(from c in Category, order_by: [{:asc, c.id}])
    for category <- categories, do: %{name: category.name,
        id: category.id}
  end
end
