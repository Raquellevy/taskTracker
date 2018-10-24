defmodule TaskTracker.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "timeblocks" do
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    field :task_id, :id
    belongs_to :taskitem, TaskTracker.Taskitems.Taskitem

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start_time, :end_time, :task_id])
    |> validate_required([:start_time, :end_time, :task_id])
  end
end
