defmodule ElixirChina.CategoryControllerTest do
  use ElixirChina.ConnCase

  test "lists all posts when there's no chosen category", %{conn: conn} do
    user = insert_user
    insert_post(%{user_id: user.id})
    conn = get conn, category_path(conn, :index)
    assert html_response(conn, 200) =~ "Elixir is cool"
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
    user = insert_user
    post = insert_post(%{user_id: user.id})
    insert_post(%{user_id: user.id, category_id: 2})
    conn = get conn, category_path(conn, :show, "1")
    assert List.first(conn.assigns.posts).id == post.id
  end

end
