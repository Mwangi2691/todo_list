defmodule TodoList.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoList.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        end_date: ~D[2025-07-03],
        start_date: ~D[2025-07-03],
        status: true,
        task_description: "some task_description",
        task_name: "some task_name"
      })
      |> TodoList.Tasks.create_task()

    task
  end
end
