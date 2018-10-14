defmodule TaskTracker.Taskitems.Taskitem do
  use Ecto.Schema
  import Ecto.Changeset


  schema "taskitems" do
    field :assignedto, :string
    field :complete, :boolean, default: false
    field :description, :string
    field :timespent, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(taskitem, attrs) do
    taskitem
    |> cast(attrs, [:title, :description, :complete, :timespent, :assignedto])
    |> validate_required([:title, :description, :complete, :timespent, :assignedto])
  end
end
