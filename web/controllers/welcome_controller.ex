defmodule ElixirChina.WelcomeController do
  import ElixirChina.ControllerUtils
  use Phoenix.Controller

  def index(conn, _params) do
    render conn, "index", user_id: get_session(conn, :user_id)
  end
end