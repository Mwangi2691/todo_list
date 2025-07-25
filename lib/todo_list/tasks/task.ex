defmodule TodoList.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :status, :boolean, default: false
    field :task_name, :string
    field :task_description, :string
    field :priority, :string
    field :start_date, :date
    field :end_date, :date

    belongs_to :user, TodoList.Accounts.User

    has_many :comments, TodoList.Tasks.Comment, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:task_name, :task_description, :priority, :start_date, :end_date, :status, :user_id])
    |> validate_required([:task_name, :priority, :start_date, :end_date, :status, :user_id])
  end
end
