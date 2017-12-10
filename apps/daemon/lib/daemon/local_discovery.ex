defmodule GitPeer.Daemon.LocalDiscovery do
  @moduledoc false

  defp parse_ip(ip) when is_tuple(ip) do
    {:ok, ip}
  end

  defp parse_ip(ip) when is_binary(ip) do
    ip
    |> String.to_charlist()
    |> :inet_parse.address()
  end

  def set_ip(ip) do
    with {:ok, ip_tuple} <- parse_ip(ip),
         :ok <- Mdns.Server.set_ip(ip_tuple) do
      :ok
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  @doc """
  This does not work since there is a problem with the libary
  where they don't actually support this.
  """
  def broadcast_connection_info(ip, port) do
    with ip_charlist when is_list(ip_charlist) <- :inet_parse.ntoa(ip),
         ip_string <- List.to_string(ip_charlist) do
      Mdns.Server.add_service(%Mdns.Server.Service{
        domain: "_gitpeer._tcp.local",
        data: ["ip=#{ip_string}", "port=#{port}"],
        ttl: 120,
        type: :txt
      })
    end
  end
end
