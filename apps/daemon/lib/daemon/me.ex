defmodule GitPeer.Daemon.Me do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: __MODULE__])
  end

  def init(:ok) do
    {:ok, nil}
  end

  def set(user) do
    GenServer.cast(__MODULE__, {:set, user})
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def handle_cast({:set, user}, _user) do
    {:noreply, user}
  end

  def handle_call(:get, _from, user) do
    {:reply, user, user}
  end
end
