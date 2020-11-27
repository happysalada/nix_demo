defmodule NixDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      NixDemo.Repo,
      # Start the Telemetry supervisor
      NixDemoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: NixDemo.PubSub},
      # Start the Endpoint (http/https)
      NixDemoWeb.Endpoint
      # Start a worker by calling: NixDemo.Worker.start_link(arg)
      # {NixDemo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NixDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NixDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
