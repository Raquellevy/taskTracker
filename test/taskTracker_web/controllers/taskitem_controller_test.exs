defmodule TaskTrackerWeb.TaskitemControllerTest do
  use TaskTrackerWeb.ConnCase

  alias TaskTracker.Taskitems

  @create_attrs %{assignedto: "some assignedto", complete: true, description: "some description", timespent: 42, title: "some title"}
  @update_attrs %{assignedto: "some updated assignedto", complete: false, description: "some updated description", timespent: 43, title: "some updated title"}
  @invalid_attrs %{assignedto: nil, complete: nil, description: nil, timespent: nil, title: nil}

  def fixture(:taskitem) do
    {:ok, taskitem} = Taskitems.create_taskitem(@create_attrs)
    taskitem
  end

  describe "index" do
    test "lists all taskitems", %{conn: conn} do
      conn = get(conn, Routes.taskitem_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Taskitems"
    end
  end

  describe "new taskitem" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.taskitem_path(conn, :new))
      assert html_response(conn, 200) =~ "New Taskitem"
    end
  end

  describe "create taskitem" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.taskitem_path(conn, :create), taskitem: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.taskitem_path(conn, :show, id)

      conn = get(conn, Routes.taskitem_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Taskitem"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.taskitem_path(conn, :create), taskitem: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Taskitem"
    end
  end

  describe "edit taskitem" do
    setup [:create_taskitem]

    test "renders form for editing chosen taskitem", %{conn: conn, taskitem: taskitem} do
      conn = get(conn, Routes.taskitem_path(conn, :edit, taskitem))
      assert html_response(conn, 200) =~ "Edit Taskitem"
    end
  end

  describe "update taskitem" do
    setup [:create_taskitem]

    test "redirects when data is valid", %{conn: conn, taskitem: taskitem} do
      conn = put(conn, Routes.taskitem_path(conn, :update, taskitem), taskitem: @update_attrs)
      assert redirected_to(conn) == Routes.taskitem_path(conn, :show, taskitem)

      conn = get(conn, Routes.taskitem_path(conn, :show, taskitem))
      assert html_response(conn, 200) =~ "some updated assignedto"
    end

    test "renders errors when data is invalid", %{conn: conn, taskitem: taskitem} do
      conn = put(conn, Routes.taskitem_path(conn, :update, taskitem), taskitem: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Taskitem"
    end
  end

  describe "delete taskitem" do
    setup [:create_taskitem]

    test "deletes chosen taskitem", %{conn: conn, taskitem: taskitem} do
      conn = delete(conn, Routes.taskitem_path(conn, :delete, taskitem))
      assert redirected_to(conn) == Routes.taskitem_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.taskitem_path(conn, :show, taskitem))
      end
    end
  end

  defp create_taskitem(_) do
    taskitem = fixture(:taskitem)
    {:ok, taskitem: taskitem}
  end
end
