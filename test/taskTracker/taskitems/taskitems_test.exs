defmodule TaskTracker.TaskitemsTest do
  use TaskTracker.DataCase

  alias TaskTracker.Taskitems

  describe "taskitems" do
    alias TaskTracker.Taskitems.Taskitem

    @valid_attrs %{assignedto: "some assignedto", complete: true, description: "some description", timespent: 42, title: "some title"}
    @update_attrs %{assignedto: "some updated assignedto", complete: false, description: "some updated description", timespent: 43, title: "some updated title"}
    @invalid_attrs %{assignedto: nil, complete: nil, description: nil, timespent: nil, title: nil}

    def taskitem_fixture(attrs \\ %{}) do
      {:ok, taskitem} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Taskitems.create_taskitem()

      taskitem
    end

    test "list_taskitems/0 returns all taskitems" do
      taskitem = taskitem_fixture()
      assert Taskitems.list_taskitems() == [taskitem]
    end

    test "get_taskitem!/1 returns the taskitem with given id" do
      taskitem = taskitem_fixture()
      assert Taskitems.get_taskitem!(taskitem.id) == taskitem
    end

    test "create_taskitem/1 with valid data creates a taskitem" do
      assert {:ok, %Taskitem{} = taskitem} = Taskitems.create_taskitem(@valid_attrs)
      assert taskitem.assignedto == "some assignedto"
      assert taskitem.complete == true
      assert taskitem.description == "some description"
      assert taskitem.timespent == 42
      assert taskitem.title == "some title"
    end

    test "create_taskitem/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taskitems.create_taskitem(@invalid_attrs)
    end

    test "update_taskitem/2 with valid data updates the taskitem" do
      taskitem = taskitem_fixture()
      assert {:ok, %Taskitem{} = taskitem} = Taskitems.update_taskitem(taskitem, @update_attrs)

      
      assert taskitem.assignedto == "some updated assignedto"
      assert taskitem.complete == false
      assert taskitem.description == "some updated description"
      assert taskitem.timespent == 43
      assert taskitem.title == "some updated title"
    end

    test "update_taskitem/2 with invalid data returns error changeset" do
      taskitem = taskitem_fixture()
      assert {:error, %Ecto.Changeset{}} = Taskitems.update_taskitem(taskitem, @invalid_attrs)
      assert taskitem == Taskitems.get_taskitem!(taskitem.id)
    end

    test "delete_taskitem/1 deletes the taskitem" do
      taskitem = taskitem_fixture()
      assert {:ok, %Taskitem{}} = Taskitems.delete_taskitem(taskitem)
      assert_raise Ecto.NoResultsError, fn -> Taskitems.get_taskitem!(taskitem.id) end
    end

    test "change_taskitem/1 returns a taskitem changeset" do
      taskitem = taskitem_fixture()
      assert %Ecto.Changeset{} = Taskitems.change_taskitem(taskitem)
    end
  end
end
