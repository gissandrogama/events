defmodule EventsApi.Accounts.Auth.Session do
  @moduledoc """
  Esse modulo possui a funçã `authenticate/2`, que verifica se um usuário existe.
  """
  import Ecto.Query, warn: false
  alias EventsApi.Accounts.User
  alias EventsApi.Repo

  @doc """
  Essa função válida se um usuário existe, para validar é feito uma consulta pelo `email`. Caso
  o usuário exista é feito uma comparação com o `password` passado pelo usuário e o que consta no
  cadastro, se tudo estiver correto é retornado um usuário.

  ## Paramentros da função
  - email: email que pertence ao usuário
  - password: senha cadastrada pelo usuário

  ## Informações adcionais
    - caso email ou senha estejam errados é gerado um erro.

  ## Example empty lists

       iex> EventsApi.Accounts.create_user(%{email: "teste@email.com", name: "teste 1", password: "123123"})
       iex> authenticate("teste@email.com", "123123")
       {:ok, %User{}}

  """
  def authenticate(email, password) do
    query = from u in User, where: u.email == ^email

    case Repo.one(query) do
      nil ->
        {:error, :not_found}

      user ->
        if Argon2.verify_pass(password, user.password_hash) do
          {:ok, user}
        else
          {:error, :unauthorizade}
        end
    end
  end
end
