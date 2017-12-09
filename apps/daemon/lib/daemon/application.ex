defmodule GitPeer.Daemon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias GitPeer.Daemon.{Me, User}

  def start(_type, _args) do

    # List all child processes to be supervised
    children = [
      {Me, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GitPeer.Daemon.Supervisor]
    ret = Supervisor.start_link(children, opts)

    with {:ok, user_info} <- User.get_user_and_public_key() do
      User.set_user(user_info)
      Me.set(user_info)
    end

    ret
  end
end
