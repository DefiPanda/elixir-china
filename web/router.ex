defmodule ElixirChina.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :elixir_china

  scope alias: ElixirChina do
    get "/", WelcomeController, :index, as: :root
    get "/pages/:page", PageController, :show, as: :page
    resources "/posts", PostController do
      resources "/comments", CommentController
   	end
  end

end
