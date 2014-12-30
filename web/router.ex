defmodule ElixirChina.Router do
  use Phoenix.Router

  scope alias: ElixirChina do
    get "/", CategoryController, :index, as: :root
    get "/pages/:page", PageController, :show, as: :page

    # Posts and comments
    resources "/posts", PostController do
      resources "/comments", CommentController, except: [:index, :new, :show]
    end

    resources "/users", UserController do
      resources "/posts", PostController, only: [:index]
      resources "/notifications", NotificationController, only: [:index, :destroy]
    end

    resources "/categories", CategoryController, only: [:index, :show]

    # Users
    get "/signup", UserController, :new

    # Sessions
    resources "/sessions", SessionController, only: [:new, :create]
    get "/signin", SessionController, :new
    get "/signout", SessionController, :destroy
  end
end
