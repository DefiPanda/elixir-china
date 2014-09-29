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

    resources "/users", UserController do
      resources "/posts", PostController, only: [:index]
    end

    resources "/categories", CategoryController, only: [:index, :show]

    # Users
    resources "/users", UserController
    get "/signup", UserController, :new

    # Sessions
    resources "/sessions", SessionController, only: [:new, :create]
    get "/signin", SessionController, :new
    get "/signout", SessionController, :destroy
  end

end
