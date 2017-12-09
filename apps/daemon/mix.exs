defmodule GitPeer.Daemon.MixProject do
  use Mix.Project

  def project do
    [
      app: :daemon,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {GitPeer.Daemon.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:git_cli, "~> 0.2.4"},
      {:gitex, "~> 0.2.0"},
      {:git_diff, "~> 0.3.0"},
    ]
  end
end
