defmodule GitPeer.Daemon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # Doesn't work now need to patch upstream
    # Mdns.Server.start()
    # List all child processes to be supervised
    children = []

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GitPeer.Daemon.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
