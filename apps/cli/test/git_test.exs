defmodule GitPeer.Cli.GitTest do
  use ExUnit.Case
  doctest GitPeer.Cli.Git, import: true
  alias Git, as: GitCli
  alias GitPeer.Cli

  setup do
    path = GitSetup.repo_path()

    {:ok, %{gitex_repo: gitex_repo, git_cli_repo: git_cli_repo}} =
      GitSetup.create_repo(path)

    %{path: path, gitex_repo: gitex_repo, git_cli_repo: git_cli_repo}
  end

  setup_all do
    on_exit(fn ->
      System.tmp_dir!()
      |> Path.join("repo_*")
      |> Path.wildcard()
      |> Enum.each(&File.rm_rf/1)
    end)
  end

  test "Get current repo directory", %{path: path} do
    File.cd(path)
    {:ok, repo_path} = Cli.Git.get_current_repo_directory()

    assert path === repo_path
  end

  test "Get current repo", %{path: path} do
    File.cd(path)
    {:ok, %{path: repo_path}} = Cli.Git.get_current_repo()

    assert path === repo_path
  end

  test "Get diff path", %{gitex_repo: gitex_repo, git_cli_repo: git_cli_repo} do
    files = ~w(file1 file2)

    "master"
    |> Gitex.put(gitex_repo, "/file1", "")
    |> Gitex.put(gitex_repo, "/file2", "")
    |> Gitex.commit(gitex_repo, "new_thing", "first")

    GitCli.checkout(git_cli_repo, ~w(new_thing))
    {:ok, actual_files} = Cli.Git.get_diff_files(git_cli_repo)

    assert files === actual_files
  end

  test "Get current branch", %{git_cli_repo: git_cli_repo} do
    branch = "master"
    {:ok, actual_branch} = Cli.Git.get_current_branch(git_cli_repo)

    assert branch === actual_branch
  end

  test "Get current hash", %{git_cli_repo: git_cli_repo, gitex_repo: gitex_repo} do
    %{hash: hash} = Gitex.get("master", gitex_repo)
    {:ok, actual_hash} = Cli.Git.get_current_hash(git_cli_repo)

    assert hash === actual_hash
  end
end
