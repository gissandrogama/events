defmodule EventsApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias EventsApi.Doings.Event

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :events, Event

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> cast_assoc(:events, with: &Event.changeset/2)
    |> validate_required([:name], message: "É necessário preencher o nome")
    |> validate_email()
    |> validate_password()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email], message: "É necessário preencher o email")
    |> unique_constraint(:email, message: "E-mail já cadastrado!")
    |> validate_format(:email, ~r/@/, message: "E-mail inválido!")
    |> update_change(:email, &String.downcase/1)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password], message: "É necessário preencher o password")
    |> validate_length(:password, min: 6, message: "password deve conter no mínimo 6 caracteres")
    |> hashing()
  end

  defp hashing(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp hashing(changeset), do: changeset
end
