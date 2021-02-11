defmodule EventsApi.Accounts do
  @moduledoc """
  Este modulo possui funções que persiste usuário no banco.
  Função `create_user/1`
  """
  alias EventsApi.{Accounts.User, Repo}

  @doc """
  Função que insere o usuário no banco de dados. Essa função recebe um `map` com os campos e valores,
  faz um parser para `User.changeset/2`, que valida as informações e retorna uma estrutura valida ou não.any()


  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
