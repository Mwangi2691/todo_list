defmodule TodoList.Tasks.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :comment_text, :string
    belongs_to :task, TodoList.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:comment_text, :task_id])
    |> validate_required([:comment_text, :task_id])
  end
end
