defmodule ElixirChina.CategoryControllerTest do
  use ElixirChina.ConnCase

  alias ElixirChina.Post

  @valid_attrs %{title: "Post Title", content: "Post content.", category_id: 1, user_id: 1}
  @valid_attrs1 %{title: "Post 2 Title", content: "Post 2 content.", category_id: 2, user_id: 2}
  @invalid_attrs %{}

  test "lists all posts when there's no chosen category", %{conn: conn} do
    Repo.insert(Post.changeset(%Post{}, @valid_attrs))
    conn = get conn, category_path(conn, :index)
    assert html_response(conn, 200) =~ "Post Title"
    assert conn.assigns.page == 1
  end

  test "lists posts of one page", %{conn: conn} do
    conn = get conn, category_path(conn, :index, page: 2)
    assert html_response(conn, 200)
    assert conn.assigns.page == 2
  end

  @tag :skip
  test "display creating post button when there's signed in user", %{conn: conn} do
    # TODO: http://stackoverflow.com/questions/31983077/how-can-i-set-session-in-setup-when-i-test-phoenix-action-which-need-user-id-in
    put_session(conn, :user_id, 1)
    conn = get conn, category_path(conn, :index, page: 2)
    assert html_response(conn, 200) =~ "发布话题"
  end

  test "lists posts of one category", %{conn: conn} do
    post = Repo.insert!(Post.changeset(%Post{}, @valid_attrs))
    Repo.insert(Post.changeset(%Post{}, @valid_attrs1))
    conn = get conn, category_path(conn, :show, 1)
    assert List.first(conn.assigns.posts).id == post.id
  end

end
