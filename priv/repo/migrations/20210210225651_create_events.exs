defmodule EventsApi.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :date_initial, :string
      add :date_finish, :string
      add :description, :text
      add :start_time, :string
      add :end_time, :string
      add :place, :string
      add :andress, :string
      add :url_img, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:events, [:user_id])
  end
end
