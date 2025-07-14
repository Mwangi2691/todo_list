defmodule TodoList.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :comment_text, :string
      add :task_id, references(:tasks, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:comments, [:task_id])
  end
end
