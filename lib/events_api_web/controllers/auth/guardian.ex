defmodule EventsApiWeb.Auth.Guardian do
  @moduledoc """
  Modulo tem funções que autenticam um usuário e geram token
  """
  use Guardian, otp_app: :events_api

  alias EventsApi.Accounts
  alias EventsApi.Accounts.Auth.Session

  def subject_for_token(user, _claims), do: {:ok, to_string(user.id)}

  def resource_from_claims(claims) do
    user =
      claims["sub"]
      |> Accounts.get_user!()

    {:ok, user}
  end

  def authenticate(email, password) do
    case Session.authenticate(email, password) do
      {:ok, user} ->
        create_token(user)

      _ ->
        {:error, :unauthorizade}
    end
  end

  defp create_token(user) do
    {:ok, token, _claim} = encode_and_sign(user)
    {:ok, user, token}
  end
end
