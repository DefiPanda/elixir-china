defmodule ElixirChina.CategoryController do
  use ElixirChina.Web, :controller

  alias ElixirChina.Post
  alias ElixirChina.Comment
  alias ElixirChina.User
  alias ElixirChina.Category

  plug :set_statics when action in [:index, :show]
  defp set_statics(conn, _msg) do
    conn
    |> assign(:show_statics, true)
    |> assign(:post_count, Repo.one(Post.count))
    |> assign(:comment_count, Repo.one(Comment.count))
    |> assign(:user_count, Repo.one(User.count))
    |> assign(:leading_users, Repo.all(User.leading))
  end

  plug :set_user
  defp set_user(conn, _msg) do
    assign(conn, :user_id, get_session(conn, :user_id))
  end

  def index(conn, %{"page" => page}) do
    page = String.to_integer(page)
    paged_posts = get_posts_by_page(page)

    render conn, "index.html", categories: Repo.all(Category),
                      posts: paged_posts.entries |> Repo.preload([:user, :category]),
                      pages: paged_posts.total_pages,
                      page: page
  end

  def index(conn, %{}) do
    index(conn, %{"page" => "1"})
  end

  def show(conn, %{"id" => id, "page" => page}) do
    id = String.to_integer(id)
    paged_posts = get_posts_by_page(page, id)
    render conn, "show.html", categories: Repo.all(Category),
                      posts: paged_posts.entries |> Repo.preload([:user, :category]),
                      category_id: id,
                      pages: paged_posts.total_pages,
                      page: page
  end

  def show(conn, %{"id" => id}) do
    show(conn, %{"id" => id, "page" => 1})
  end

  defp get_posts_by_page(page) do
    Post.recent
    |> Repo.paginate(page: page)
  end

  defp get_posts_by_page(page, id) do
    Post.by_category_id(id)
    |> Post.recent
    |> Repo.paginate(page: page)
  end
end
