defmodule GitPeer.Cli.Review do
  @moduledoc """
  cli for review command
  """

  def optimus_config() do
    [
      name: "review",
      about: "Allows you to review another user's code, or post your code for review",
      subcommands: [
        request: [
          name: "request",
          about: "Request a review from one or more users (default all users)",
          args: [
            ref: [
              value_name: "REF",
              help: "Branch or commit hash",
              required: true,
              parser: :string
            ],
          ],
          options: [
            users: [
              value_name: "USERS",
              short: "-u",
              long: "--users",
              help: "The users you would like to review",
              required: false,
              multiple: true,
              parser: :string
            ]
          ]
        ],
        open: [
          name: "open",
          about: "Opens a review",
          args: [
            ref: [
              value_name: "REF",
              help: "The branch or commit hash to review",
              required: true,
              parser: :string
            ]
          ],
          options: [
            user: [
              name: "user",
              short: "-u",
              long: "--user",
              value_name: "USER",
              help: "The user with the review to open",
              required: false,
              parser: :string
            ],
          ]
        ],
        list: [
          name: "list",
          about: "List commits for review",
          options: [
            users: [
              short: "-u",
              long: "--users",
              value_name: "USERS",
              help: "The users who have commits you wish to review",
              parser: :string,
              multiple: true
            ]
          ]
        ],
        start: [
          name: "start",
          about: "Starts a review on a commit",
          args: [
            ref: [
              value_name: "REF",
              required: true,
              parser: :string,
              help: "The branch or commit hash to review"
            ]
          ],
          options: [
            user: [
              short: "-u",
              long: "--user",
              required: true,
              value_name: "USER",
              help: "The user who's commit to review"
            ]
          ]
        ]
      ]
    ]
  end

  def command({[:request], %{args: %{ref: ref}, options: %{users: []}}}) do
    IO.puts("#{ref} put up for review")
  end
  def command({[:request], %{args: %{ref: ref}, options: %{users: users}}}) do
    IO.puts("#{ref} put up for review by #{Enum.join(users, " ")}")
  end
  def command({[:start], %{args: %{ref: ref}, options: %{user: user}}}) do
    IO.puts("Begin review on #{ref} by #{user}")
  end
  def command({[:open], %{args: %{ref: ref}, options: %{user: nil}}}) do
    IO.puts("Open review on #{ref} by me")
  end
  def command({[:open], %{args: %{ref: ref}, options: %{user: user}}}) do
    IO.puts("Open review on #{ref} by #{user}")
  end
  def command({[:list], %{options: %{users: []}}}) do
    IO.puts("List all reviews")
  end
  def command({[:list], %{options: %{users: users}}}) do
    IO.puts("List all reviews for #{Enum.join(users, " and ")}")
  end
end
