defmodule TaskTrackerWeb.TaskitemController do
  use TaskTrackerWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias TaskTracker.Taskitems
  alias TaskTracker.Taskitems.Taskitem
  alias TaskTracker.Users
  alias TaskTracker.Users.User
  alias TaskTracker.Repo

  def index(conn, _params) do
    taskitems = Taskitems.list_taskitems()
    users = Users.list_users()
    user_id = conn.assigns[:current_user].id
    mytasks = Repo.all from ti in Taskitem, where: ti.user_id == ^user_id 
    underlings = Repo.all from u in User, where: u.manager_id == ^user_id
    render(conn, "index.html", taskitems: taskitems, mytasks: mytasks, users: users, underlings: underlings)
  end

  def new(conn, _params) do
    users = Users.list_users()
    user_id = conn.assigns[:current_user].id
    underlings = Repo.all from u in User, where: u.manager_id == ^user_id
    changeset = Taskitems.change_taskitem(%Taskitem{})
    render(conn, "new.html", changeset: changeset, users: users, underlings: underlings)
  end

  def create(conn, %{"taskitem" => taskitem_params}) do
    users = Users.list_users()
    user_id = conn.assigns[:current_user].id
    underlings = Repo.all from u in User, where: u.manager_id == ^user_id

    case Taskitems.create_taskitem(taskitem_params) do
      {:ok, taskitem} ->
        conn
        |> put_flash(:info, "Taskitem created successfully.")
        |> redirect(to: Routes.taskitem_path(conn, :show, taskitem))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users, underlings: underlings)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Users.list_users()
    taskitem = Taskitems.get_taskitem!(id)
    render(conn, "show.html", taskitem: taskitem, users: users)
  end

  def show_tasks(conn, user) do
    taskitems = Taskitems.list_taskitems()
    render(conn, "show_tasks.html", taskitems: taskitems)
  end


  def edit(conn, %{"id" => id}) do
    users = Users.list_users()
    taskitem = Taskitems.get_taskitem!(id)
    changeset = Taskitems.change_taskitem(taskitem)
    user_id = conn.assigns[:current_user].id
    underlings = Repo.all from u in User, where: u.manager_id == ^user_id
    render(conn, "edit.html", taskitem: taskitem, changeset: changeset, users: users, underlings: underlings)
  end

  def update(conn, %{"id" => id, "taskitem" => taskitem_params}) do
    users = Users.list_users()
    taskitem = Taskitems.get_taskitem!(id)
    user_id = conn.assigns[:current_user].id
    underlings = Repo.all from u in User, where: u.manager_id == ^user_id

    case Taskitems.update_taskitem(taskitem, taskitem_params) do
      {:ok, taskitem} ->
        conn
        |> put_flash(:info, "Taskitem updated successfully.")
        |> redirect(to: Routes.taskitem_path(conn, :show, taskitem))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", taskitem: taskitem, changeset: changeset, users: users, underlings: underlings)
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
