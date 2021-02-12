defmodule EventsApi.Accounts.Auth.Session do
  import Ecto.Query, warn: false
  alias EventsApi.Repo
  alias EventsApi.Accounts.User

  def authenticate(email, password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil -> {:error, :not_found}

      user ->
        if Argon2.verify_pass(password, user.password_hash) do
          {:ok, user}
        else
          {:error, :unauthorizade}
        end
    end
  end
end
