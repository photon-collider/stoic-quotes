defmodule StoicQuotes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      StoicQuotesWeb.Telemetry,
      # Start the Ecto repository
      StoicQuotes.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: StoicQuotes.PubSub},
      # Start Finch
      {Finch, name: StoicQuotes.Finch},
      # Start the Endpoint (http/https)
      StoicQuotesWeb.Endpoint
      # Start a worker by calling: StoicQuotes.Worker.start_link(arg)
      # {StoicQuotes.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StoicQuotes.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StoicQuotesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
