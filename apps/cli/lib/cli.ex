defmodule GitPeer.Cli do
  @moduledoc """
  Documentation for GitPeer.Cli.
  """

  alias GitPeer.Cli.{Review, Connect, Conflict, Branch}

  def main([]) do
    IO.puts("git-peer: A distributed Git collboration tool\n")
    valid_commands()
  end
  def main(["review" | args]) do
    Review.main(args)
  end
  def main(["connect" | args]) do
    Connect.main(args)
  end
  def main(["conflict" | args]) do
    Conflict.main(args)
  end
  def main(["branch" | args]) do
    Branch.main(args)
  end
  def main([invalid_command | _]) do
    IO.puts("git-peer - Invalid command \"#{invalid_command}\"\n")
    valid_commands()
  end

  defp valid_commands() do
    IO.puts("Valid commands include:")
    IO.puts("review   - Allows you to review a ref, or request a review on a ref")
    IO.puts("connect  - Allows you to connect to a git-peer network")
    IO.puts("conflict - Allows you to perform conflict resolution")
    IO.puts("branch   - Allows you to view and manage branches")
  end
end
