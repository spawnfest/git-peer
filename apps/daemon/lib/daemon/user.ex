defmodule GitPeer.Daemon.User do
  def get_user_and_public_key do
    public_key = Path.expand("~/.ssh/id_rsa.pub")

    with {:ok, public_key_content} when is_binary(public_key_content) <- File.read(public_key),
         public_key_content <- String.trim(public_key_content),
         %{"key" => _, "user" => _} = result <-
           Regex.named_captures(~r/^ssh-rsa (?<key>\S+) (?<user>\S+)$/, public_key_content) do
      {:ok, result}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end
end
