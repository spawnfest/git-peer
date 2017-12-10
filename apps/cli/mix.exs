defmodule GitPeer.Cli.MixProject do
  @moduledoc """
  Mix configuration for GitPeer.Cli
  """

  use Mix.Project

  def project do
    [
      app: :cli,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: GitPeer.Cli, name: "git-peer", emu_args: ["-sname client -cookie whatever"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:lager, :logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:git_cli, "~> 0.2.4"},
      {:gitex, "~> 0.2.0"},
      {:logger_lager_backend, "~> 0.1.0"},
      {:optimus, "~> 0.1.0"}
    ]
  end
end
