defmodule GitPeer.Services.User do
  @moduledoc """
  User services
  """

  def set_user(%{"user" => user, "key" => key}) do
    :lasp.update(
      {"users", :state_awmap},
      {:apply, user, {:add, %{"key" => key}}},
      self()
    )
  end

  def get_users do
    with {:ok, users} when is_list(users) <-
           :lasp.query({"users", :state_awmap}) do
      users
      |> Enum.map(fn {key, value} -> {key, :sets.to_list(value)} end)
      |> Enum.into(%{})
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end
end
