defmodule ElixirChina.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  scope "/", ElixirChina do
    pipe_through :browser

    get "/", CategoryController, :index, as: :root
    get "/pages/:page", PageController, :show, as: :page

    # Posts and comments
    resources "/posts", PostController do
      resources "/comments", CommentController, except: [:index, :new, :show, :destroy]
    end

    resources "/users", UserController do
      resources "/posts", PostController, only: [:index]
    end

    resources "/notifications", NotificationController, only: [:index, :destroy]
    
    resources "/categories", CategoryController, only: [:index, :show]

    # Users
    get "/signup", UserController, :new

    # Sessions
    resources "/sessions", SessionController, only: [:new, :create]
    get "/signin", SessionController, :new
    get "/signout", SessionController, :destroy
  end
end