defmodule GitPeer.Cli do
  @moduledoc """
  Documentation for GitPeer.Cli.
  """

  alias GitPeer.Cli.{Review, Connect, Conflict, Branch}

  def main(argv) do
    optimus_config()
    |> Optimus.new!()
    |> Optimus.parse!(argv)
    |> IO.inspect(label: :optimus_in_main)
    |> command()
  end

  defp command({[:review | subcommands], parse_result}) do
    Review.command({subcommands, parse_result})
  end
  defp command({[:connect | subcommands], parse_result}) do
    Connect.command({subcommands, parse_result})
  end
  defp command({[:conflict | subcommands], parse_result}) do
    Conflict.command({subcommands, parse_result})
  end
  defp command({[:branch | subcommands], parse_result}) do
    Branch.command({subcommands, parse_result})
  end

  def optimus_config() do
    [
      name: "git-peer",
      description: "A distributed Git collaboration tool",
      version: "0.0.1",
      author: "Olafur Arason",
      about: "A tool for sharing and reviewing your source code over a network in a peer to peer fashion.",
      allow_unknown_args: false,
      parse_double_dash: true,
      subcommands: [
        review: Review.optimus_config(),
      ]
    ]
  end
end
