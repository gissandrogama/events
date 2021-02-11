defmodule EventsApi.Accounts do
  alias EventsApi.{Accounts.User, Repo}

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
