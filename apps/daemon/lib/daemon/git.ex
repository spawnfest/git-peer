defmodule GitPeer.Daemon.Git do
  alias Git, as: GitCli

  def get_current_repo_directory do
    with {console_output, 0} <- System.cmd("git", ["rev-parse", "--show-toplevel"]) do
      repo_directory = String.trim(console_output, "\n")
      {:ok, repo_directory}
    else
      {:error, error} ->
        {:error, error}

      {console_output, error_code} ->
        {:error, %{console_output: console_output, error_code: error_code}}

      error ->
        {:error, error}
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

  def get_diff_files(%GitCli.Repository{} = repo) do
    with {:ok, diff} <- GitCli.diff(repo, ["--stat", "master"]) do
      files =
        diff
        |> String.split("\n")
        |> Enum.map(&Regex.named_captures(~r/ *(?<path>\S*) *\|/, &1))
        |> Enum.filter(&(not is_nil(&1)))
        |> Enum.map(&Map.get(&1, "path"))

      {:ok, files}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  def get_current_branch(%GitCli.Repository{} = repo) do
    with {:ok, branch} <- GitCli.rev_parse(repo, ~w(--abbrev-ref HEAD)) do
      branch =
        branch
        |> String.trim()

      {:ok, branch}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end
end
