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
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:lager, :logger],
      mod: {GitPeer.Daemon.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:logger_lager_backend, "~> 0.1.0"},
      {:lasp, "~> 0.8.2"}
    ]
  end
end
