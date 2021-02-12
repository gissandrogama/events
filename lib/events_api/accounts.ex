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

      iex> EventsApi.create_user(%{field: value})
      {:ok, %EventsApi.Accounts.User{}}

      iex> EventsApi.create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Essa função busca um usuário pelo `id`.

  ## Paramentros da função
  - id: `id` numero de indentificação do usuário

  ## Informações adcionais
    - caso id estaja incorreto ou não exista é retornado um erro.

  ## Example empty lists

       iex> user = EventsApi.Accounts.create_user(%{email: "teste@email.com", name: "teste 1", password: "123123"})
       iex> get_user(user.id)
       {:ok, %EventsApi.Accounts.User{}}

  """
  def get_user!(id) do
    Repo.get_by(User, id: id)
    |> case do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
