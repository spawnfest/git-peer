defmodule GitPeer.Daemon do
  @moduledoc """
  Documentation for GitPeer.Daemon.
  """

  alias GitPeer.Services

  def add_user(%{"user" => user, "key" => key}) do
    Services.User.set_user(%{"user" => user, "key" => key})
  end

  def get_users do
    Services.User.get_users()
  end

  def request_review(%{requester: requester, ref: ref, diff: diff, users: user}) do
    Services.Review.request_review(%{
      requester: requester,
      ref: ref,
      diff: diff,
      users: user
    })
  end

  def get_reviews do
    Services.Review.get_reviews()
  end

  def review_response(%{
        requester: requester,
        ref: ref,
        reviewer: reviewer,
        review: review
      }) do
    Services.Review.review_response(%{
      requester: requester,
      ref: ref,
      reviewer: reviewer,
      review: review
    })
  end

  def get_reviews do
    Services.Review.get_reviews()
  end
end
