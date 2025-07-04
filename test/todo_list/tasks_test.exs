defmodule TodoList.TasksTest do
  use TodoList.DataCase

  alias TodoList.Tasks

  describe "tasks" do
    alias TodoList.Tasks.Task

    import TodoList.TasksFixtures

    @invalid_attrs %{status: nil, task_name: nil, task_description: nil, start_date: nil, end_date: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tasks.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{status: true, task_name: "some task_name", task_description: "some task_description", start_date: ~D[2025-07-03], end_date: ~D[2025-07-03]}

      assert {:ok, %Task{} = task} = Tasks.create_task(valid_attrs)
      assert task.status == true
      assert task.task_name == "some task_name"
      assert task.task_description == "some task_description"
      assert task.start_date == ~D[2025-07-03]
      assert task.end_date == ~D[2025-07-03]
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{status: false, task_name: "some updated task_name", task_description: "some updated task_description", start_date: ~D[2025-07-04], end_date: ~D[2025-07-04]}

      assert {:ok, %Task{} = task} = Tasks.update_task(task, update_attrs)
      assert task.status == false
      assert task.task_name == "some updated task_name"
      assert task.task_description == "some updated task_description"
      assert task.start_date == ~D[2025-07-04]
      assert task.end_date == ~D[2025-07-04]
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task == Tasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
