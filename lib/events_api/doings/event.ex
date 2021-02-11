defmodule EventsApi.Doings.Event do
  @moduledoc """
  Modulo de schema da tabela `events`, ele possui função que valida as informações de um `map`.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias EventsApi.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :andress, :string
    field :date_finish, :string
    field :date_initial, :string
    field :description, :string
    field :end_time, :string
    field :place, :string
    field :start_time, :string
    field :title, :string
    field :url_img, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [
      :title,
      :date_initial,
      :date_finish,
      :description,
      :start_time,
      :end_time,
      :place,
      :andress,
      :url_img,
      :user_id
    ])
    |> foreign_key_constraint(:user_id)
    |> validate_required([
      :title,
      :date_initial,
      :date_finish,
      :description,
      :start_time,
      :end_time,
      :place,
      :andress,
      :url_img,
      :user_id
    ])
  end
end
