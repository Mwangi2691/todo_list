defmodule TodoList.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :task_name, :string
      add :task_description, :text
      add :start_date, :date
      add :end_date, :date
      add :status, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      timestamps(type: :utc_datetime)
    end
      create index(:tasks, [:user_id, :task_name], unique: true)

  end
end
