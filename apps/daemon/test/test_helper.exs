ExUnit.start()

defmodule GitSetup do
  def temp_name, do: "repo_" <> Base.encode16(:crypto.strong_rand_bytes(32))

  def repo_path do
    Path.join(System.tmp_dir!(), temp_name())
  end

  def create_repo(path) do
    with :ok <- File.mkdir(path) do
      {:ok, Gitex.Git.init(path)}
    else
      error -> {:error, error}
    end
  end
end
