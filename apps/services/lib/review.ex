defmodule GitPeer.Services.Review do
  @moduledoc "Service for managing reviews"

  def request_review(%{requester: requester, ref: ref, diff: diff, users: user}) do
    :lasp.update(
      {"reviews", :state_orset},
      %{requester: requester, ref: ref, diff: diff, users: user},
      self()
    )
  end

  def get_reviews do
    with {:ok, reviews} when is_list(reviews) <-
           :lasp.query({"reviews", :state_orset}) do
      reviews
      |> :sets.to_list()
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  def review_response(%{
        requester: requester,
        ref: ref,
        reviewer: reviewer,
        review: review
      }) do
    :lasp.update(
      {"review_responses", :state_orset},
      %{requester: requester, ref: ref, reviewer: reviewer, review: review},
      self()
    )
  end

  def get_reviews do
    with {:ok, reviews} when is_list(reviews) <-
           :lasp.query({"review_responses", :state_orset}) do
      reviews
      |> :sets.to_list()
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end
end
