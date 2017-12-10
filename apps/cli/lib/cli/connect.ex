defmodule GitPeer.Cli.Connect do
  @moduledoc """
  cli connect command
  """

  alias GitPeer.Daemon.Connect

  def optimus_config() do
    [
      name: "connect",
      about: "Allows you to connect to a git-peer node",
      subcommands: [
        list_ips: [
          name: "list-ips",
          help: "Lists your current IP addresses"
        ]
      ]
    ]
  end

  def command({[:list_ips], _}) do
    {:ok, hostname} = :inet.gethostname()
    hostname = List.to_string(hostname)
    server = :"server@#{hostname}" |> IO.inspect()
    Node.connect(server) |> IO.inspect(label: :connect)
    with :pong <- Node.ping(server) |> IO.inspect() do
      local_group_leader = Process.group_leader()
      local_self = self()
      Node.spawn(:"server@zach-VirtualBox", :IO, :puts, ["eh"])
      # IO.puts("GOT HERE")
      # cli_pid = self() |> IO.inspect()
      # Node.self() |> IO.inspect()
      # node = Node.spawn(server, fn () ->
      #   self() |> IO.inspect()
      #   ips = GitPeer.Daemon.Connect.list_ips() |> IO.inspect()
      #   send(cli_pid, ips)
      #   :ok
      # end)
      # node |> IO.inspect()
      # receive do
      #   ips -> IO.inspect(ips)
      # after
      #   5000 -> IO.puts(:stderr, "Couldn't get results")
      # end
    else
      :pang -> {:error, "Unable to connect to #{server}"} |> IO.inspect(label: :pang)
      error -> error |> IO.inspect(label: :wtf?)
    end
  end
end
