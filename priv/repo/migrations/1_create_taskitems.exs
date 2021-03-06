defmodule TaskTracker.Repo.Migrations.CreateTaskitems do
  use Ecto.Migration

  def change do
    create table(:taskitems) do
      add :title, :string
      add :description, :text
      add :complete, :boolean, default: false, null: false
      add :timespent, :integer
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end
end
