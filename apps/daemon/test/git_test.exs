defmodule GitPeer.Daemon.GitTest do
  use ExUnit.Case
  doctest GitPeer.Daemon.Git, import: true
  alias GitPeer.Daemon.Git

  setup do
    path = GitSetup.repo_path()
    {:ok, repo} = GitSetup.create_repo(path)

    on_exit fn ->
      File.rm_rf(path)
    end

    %{path: path, repo: repo}
  end

  test "Get current repo directory", %{path: path} do
    File.cd(path)
    {:ok, repo_path} = Git.get_current_repo_directory()

    assert path === repo_path
  end
end
