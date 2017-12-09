ExUnit.start()

defmodule GitSetup do
  alias Git, as: GitCli

  def temp_name do
    "repo_" <> Base.encode16(:crypto.strong_rand_bytes(32))
  end

  def repo_path do
    Path.join(System.tmp_dir!(), temp_name())
  end

  def create_repo(path) do
    with :ok <- File.mkdir(path),
      {:ok, git_cli_repo} <- GitCli.init(path),
      :ok <- File.write(Path.join(path, ".gitignore"), ""),
      {:ok, _} <- GitCli.add(git_cli_repo, ~w(-A)),
      {:ok, _} <- GitCli.commit(git_cli_repo, ~w(-m initial)),
      %{} = gitex_repo <- Gitex.Git.open(path) do
      {:ok, %{gitex_repo: gitex_repo, git_cli_repo: git_cli_repo}}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end
end
