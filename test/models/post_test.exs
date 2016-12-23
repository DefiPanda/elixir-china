defmodule ElixirChina.PostTest do
  use ExUnit.Case, async: true
  alias ElixirChina.Post

  test "summary/1 removes image" do
    post = %Post{content: "Body ![abc](http://abc.jpg)"}
    assert Post.summary(post) == "Body"
  end

  test "summary/1 clears format of link" do
    post = %Post{content: "Body [abc](http://abc.jpg)"}
    assert Post.summary(post) == "Body abc"
  end

  test "summary/1 clears leading formats" do
    content = """
    Body
    ## a
    > b
    * c
    """
    post = %Post{content: content}
    assert Post.summary(post) == "Body\na\nb\nc"
  end

  test "summary/1 only keeps first 100 chars" do
    post = %Post{content: String.duplicate("a", 101)}
    assert Post.summary(post) == String.duplicate("a", 100)
  end

  test "summary/1 trim content" do
    post = %Post{content: " Body  \n"}
    assert Post.summary(post) == "Body"
  end
end
