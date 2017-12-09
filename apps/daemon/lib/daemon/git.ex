defmodule GitPeer.Daemon.Git do
  alias Git, as: GitCli

  def get_current_repo_directory do
    with {console_output, 0} <- System.cmd("git", ["rev-parse", "--show-toplevel"]) do
      repo_directory = String.trim(console_output, "\n")
      {:ok, repo_directory}
    else
      {:error, error} -> {:error, error}      
      {console_output, error_code} -> {:error, %{console_output: console_output, error_code: error_code}}
      error -> {:error, error}
    end
  end

  def get_current_repo do
    with {:ok, repo_directory} <- get_current_repo_directory(),
      %GitCli.Repository{} = repo <- GitCli.new(repo_directory) do
      {:ok, repo}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end
end
