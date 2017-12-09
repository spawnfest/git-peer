defmodule GitPeer.DaemonTest do
  use ExUnit.Case
  doctest GitPeer.Daemon

  test "greets the world" do
    assert GitPeer.Daemon.hello() == :world
  end
end
