defmodule EventsApi.Doings do
  @moduledoc """
  Este modulo possui funções que persiste eventos no banco.
  Função `create_event/1`
  """
  alias EventsApi.{Doings.Event, Repo}

  @doc """
  Função que insere o eventos no banco de dados. Essa função recebe um `map` com os campos e valores,
  faz um parser para ` Event.changeset/2`, que valida as informações e retorna uma estrutura valida ou não.any()


  ## Examples

      iex> create_event(%{field: value})
      {:ok, %User{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end
end
