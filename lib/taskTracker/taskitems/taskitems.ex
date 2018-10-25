defmodule TaskTracker.Taskitems do
  @moduledoc """
  The Taskitems context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo

  alias TaskTracker.Taskitems.Taskitem

  @doc """
  Returns the list of taskitems.

  ## Examples

      iex> list_taskitems()
      [%Taskitem{}, ...]

  """
  def list_taskitems do
    Repo.all(Taskitem)
  end

  @doc """
  Gets a single taskitem.

  Raises `Ecto.NoResultsError` if the Taskitem does not exist.

  ## Examples

      iex> get_taskitem!(123)
      %Taskitem{}

      iex> get_taskitem!(456)
      ** (Ecto.NoResultsError)

  """
  def get_taskitem!(id), do: Repo.get!(Taskitem, id) |> Repo.preload(:timeblock)


  @doc """
  Creates a taskitem.

  ## Examples

      iex> create_taskitem(%{field: value})
      {:ok, %Taskitem{}}

      iex> create_taskitem(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_taskitem(attrs \\ %{}) do
    %Taskitem{}
    |> Taskitem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a taskitem.

  ## Examples

      iex> update_taskitem(taskitem, %{field: new_value})
      {:ok, %Taskitem{}}

      iex> update_taskitem(taskitem, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_taskitem(%Taskitem{} = taskitem, attrs) do
    taskitem
    |> Taskitem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Taskitem.

  ## Examples

      iex> delete_taskitem(taskitem)
      {:ok, %Taskitem{}}

      iex> delete_taskitem(taskitem)
      {:error, %Ecto.Changeset{}}

  """
  def delete_taskitem(%Taskitem{} = taskitem) do
    Repo.delete(taskitem)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking taskitem changes.

  ## Examples

      iex> change_taskitem(taskitem)
      %Ecto.Changeset{source: %Taskitem{}}

  """
  def change_taskitem(%Taskitem{} = taskitem) do
    Taskitem.changeset(taskitem, %{})
  end
end
