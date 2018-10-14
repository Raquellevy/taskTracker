defmodule TaskTrackerWeb.TaskitemController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Taskitems
  alias TaskTracker.Taskitems.Taskitem

  def index(conn, _params) do
    taskitems = Taskitems.list_taskitems()
    render(conn, "index.html", taskitems: taskitems)
  end

  def new(conn, _params) do
    changeset = Taskitems.change_taskitem(%Taskitem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"taskitem" => taskitem_params}) do
    case Taskitems.create_taskitem(taskitem_params) do
      {:ok, taskitem} ->
        conn
        |> put_flash(:info, "Taskitem created successfully.")
        |> redirect(to: Routes.taskitem_path(conn, :show, taskitem))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    taskitem = Taskitems.get_taskitem!(id)
    render(conn, "show.html", taskitem: taskitem)
  end

  def edit(conn, %{"id" => id}) do
    taskitem = Taskitems.get_taskitem!(id)
    changeset = Taskitems.change_taskitem(taskitem)
    render(conn, "edit.html", taskitem: taskitem, changeset: changeset)
  end

  def update(conn, %{"id" => id, "taskitem" => taskitem_params}) do
    taskitem = Taskitems.get_taskitem!(id)

    case Taskitems.update_taskitem(taskitem, taskitem_params) do
      {:ok, taskitem} ->
        conn
        |> put_flash(:info, "Taskitem updated successfully.")
        |> redirect(to: Routes.taskitem_path(conn, :show, taskitem))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", taskitem: taskitem, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    taskitem = Taskitems.get_taskitem!(id)
    {:ok, _taskitem} = Taskitems.delete_taskitem(taskitem)

    conn
    |> put_flash(:info, "Taskitem deleted successfully.")
    |> redirect(to: Routes.taskitem_path(conn, :index))
  end
end
