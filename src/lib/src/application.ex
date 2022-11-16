defmodule Src.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Src.Repo,
      # Start the Telemetry supervisor
      SrcWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Src.PubSub},
      # Start the Endpoint (http/https)
      SrcWeb.Endpoint
      # Start a worker by calling: Src.Worker.start_link(arg)
      # {Src.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Src.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SrcWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
