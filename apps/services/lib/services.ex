defmodule GitPeer.Services do
  @moduledoc """
  Documentation for GitPeer.Services.
  """

  alias GitPeer.Services.User

  def set_user do
    with {:ok, user_info} <- User.get_user_and_public_key() do
      User.set_user(user_info)
    end
  end
end
