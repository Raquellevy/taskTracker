defmodule TaskTracker.Repo.Migrations.AlterUser do
    use Ecto.Migration
  
    def change do
      alter table(:users) do
        add :manager_id, references(:users, on_delete: :nilify_all), default: nil
        end
  
    end
  end
  