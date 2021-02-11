defmodule EventsApi.UserFixture do
  @moduledoc """
  module that has simple functions to generate test parameters that need a user
  """

  alias EventsApi.Accounts

  def name, do: "User Admin"
  def email, do: "user#{:random.uniform()}@email.com"
  def password, do: "123456"

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: name(),
        email: email(),
        password: password()
      })
      |> Accounts.create_user()

    user
  end
end
