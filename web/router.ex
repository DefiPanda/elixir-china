defmodule ElixirChina.Router do
  use Phoenix.Router

  plug Plug.Static, at: "/static", from: :elixir_china

  scope alias: ElixirChina do
    get "/", WelcomeController, :index, as: :root
    get "/pages/:page", PageController, :show, as: :page

    # Posts and comments
    resources "/posts", PostController do
      resources "/comments", CommentController
    end

    # Users
    resources "/users", UserController
    get "/signup", UserController, :new

    # Sessions
    resources "/sessions", SessionController, only: [:new, :create, :destroy]
    get "/signin", SessionController, :new
    get "/signout", SessionController, :destroy
  end

end
