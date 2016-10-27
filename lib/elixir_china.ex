defmodule ElixirChina do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Start the Ecto repository
      worker(ElixirChina.Repo, []),
      # Start the endpoint when the application starts
      supervisor(ElixirChina.Endpoint, [])
      # Define workers and child supervisors to be supervised
      # worker(ElixirChina.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirChina.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirChina.Endpoint.config_change(changed, removed)
    :ok
  end
end
