defmodule GitPeer.Services.User do
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

  def set_user(%{"user" => user, "key" => key}) do
    :lasp.update({"users", :state_awmap}, {:apply, user, {:add, %{"key" => key}}}, self())
  end

  def get_users do
    with {:ok, users} when is_list(users) <- :lasp.query({"users", :state_awmap}) do
      Enum.map(users, fn {key, value} -> {key, :sets.to_list(value)} end)
      |> Enum.into(%{})
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end
end
