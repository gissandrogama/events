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
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Função lista todos os eventos persistidos no banco de dados.

  ## Examples

      iex> list_events()
      [%Event{}, ...]
  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Função responsavel por retornar um evento pelo id.

  ## Paramentros da função
  - id: número de identificação do evento

  ## Informações adcionais
    - caso o id passado esteja errado ou não exista é retornado um erro `{:error, :not_found}`.

  ## Example empty lists

       iex> get_event!("a37a802c-2466-41c6-b84e-15396694f886")
       {:ok, %Event{}}
  """
  def get_event!(id) do
    Repo.get_by(Event, id: id)
    |> case do
      nil -> {:error, :not_found}
      event -> {:ok, event}
    end
  end
end
