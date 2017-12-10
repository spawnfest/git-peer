defmodule GitPeer.Daemon.Connect do
  @moduledoc "Functions related to network connectivity"

  def parse_ip(ip) when is_tuple(ip) do
    {:ok, ip}
  end

  def parse_ip(ip) when is_binary(ip) do
    ip
    |> String.to_charlist()
    |> :inet_parse.address()
  end

  def join(connection_info) do
    :lasp_peer_service.join(connection_info)
  end

  def get_connection_info do
    get_partisan_info()
    |> Map.take([:listen_addrs, :name])
  end

  def get_partisan_info do
    :partisan_peer_service_manager.myself()
  end

  def list_ips do
    with {:ok, ips} <- :inet.getifaddrs() do
      ips
      |> Enum.reduce([], fn {key, features}, acc ->
           flags = Keyword.get(features, :flags, [])
           addr = Keyword.get(features, :addr, nil)

           if :multicast in flags and is_tuple(addr) do
             [{List.to_string(key), addr} | acc]
           else
             acc
           end
         end)
      |> Enum.into(%{})
    end
  end
end
