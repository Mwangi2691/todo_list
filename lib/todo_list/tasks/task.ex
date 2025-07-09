defmodule TodoList.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :status, :boolean, default: false
    field :task_name, :string
    field :task_description, :string
    field :start_date, :date
    field :end_date, :date
    # other fields...

  belongs_to :user, TodoList.Accounts.User



    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:task_name, :task_description, :start_date, :end_date, :status])
    |> validate_required([:task_name, :task_description, :start_date, :end_date, :status])
  end
end
