defmodule TaskTracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :taskitem_id, references(:taskitems, on_delete: :delete_all)

      timestamps()
    end

    create index(:timeblocks, [:taskitem_id])
  end
end
