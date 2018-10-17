defmodule TaskTracker.Taskitems.Taskitem do
  use Ecto.Schema
  import Ecto.Changeset


  schema "taskitems" do
    field :complete, :boolean, default: false
    field :description, :string
    field :timespent, :integer
    field :title, :string
    belongs_to :user, TaskTracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(taskitem, attrs) do
    taskitem
    |> cast(attrs, [:title, :description, :complete, :timespent, :user_id])
    |> validate_required([:title, :description])
  end
end
