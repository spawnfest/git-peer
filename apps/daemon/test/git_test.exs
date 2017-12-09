defmodule GitPeer.Daemon.GitTest do
  use ExUnit.Case
  doctest GitPeer.Daemon.Git, import: true
  alias Git, as: GitCli
  alias GitPeer.Daemon.Git, as: DaemonGit

  setup do
    path = GitSetup.repo_path()
    {:ok, %{gitex_repo: gitex_repo, git_cli_repo: git_cli_repo}} = GitSetup.create_repo(path)

    on_exit fn ->
      File.rm_rf(path)
    end

    %{path: path, gitex_repo: gitex_repo, git_cli_repo: git_cli_repo}
  end

  test "Get current repo directory", %{path: path} do
    File.cd(path)
    {:ok, repo_path} = DaemonGit.get_current_repo_directory()

    assert path === repo_path
  end

  test "Get current repo", %{path: path} do
    File.cd(path)
    {:ok, %{path: repo_path}} = DaemonGit.get_current_repo()

    assert path === repo_path
  end

  test "Get diff path", %{gitex_repo: gitex_repo, git_cli_repo: git_cli_repo} do
    files = ~w(file1 file2)

    "master"
    |> Gitex.put(gitex_repo, "/file1", "")
    |> Gitex.put(gitex_repo, "/file2", "")
    |> Gitex.commit(gitex_repo, "new_thing", "first")

    GitCli.checkout(git_cli_repo, ~w(new_thing))
    {:ok, actual_files} = DaemonGit.get_diff_files(git_cli_repo)

    assert files === actual_files
  end
end
