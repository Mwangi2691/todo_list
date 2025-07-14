defmodule TodoListWeb.TaskController do
  use TodoListWeb, :controller

  alias TodoList.Tasks
  alias TodoList.Tasks.Task


  plug :require_logged_in_user when action in [:index, :new, :create, :edit, :update, :delete, :show, :create_comment]

  defp require_logged_in_user(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "Please log in to continue.")
      |> redirect(to: ~p"/users/log_in")
      |> halt()
    end
  end

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    tasks = Tasks.list_tasks_for_user(current_user.id)
    render(conn, :index, tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    current_user = conn.assigns.current_user
    task_params = Map.put(task_params, "user_id", current_user.id)

    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

 def show(conn, %{"id" => id}) do
  task = Tasks.get_task_with_comments!(id)
  comment_changeset = Tasks.change_comment(%TodoList.Tasks.Comment{})
  render(conn, :show, task: task, comment_changeset: comment_changeset)
end



  def create_comment(conn, %{"task_id" => task_id, "comment" => comment_params}) do
    comment_params = Map.put(comment_params, "task_id", task_id)

    case Tasks.create_comment(comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment added.")
        |> redirect(to: ~p"/tasks/#{task_id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        task = Tasks.get_task_with_comments!(task_id)
        render(conn, :show, task: task, comment_changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, :edit, task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: ~p"/tasks")
  end
end
