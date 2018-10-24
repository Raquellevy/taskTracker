defmodule TaskTracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :task_id, references(:taskitems, on_delete: :delete_all)

      timestamps()
    end

    create index(:timeblocks, [:task_id])
  end
end
