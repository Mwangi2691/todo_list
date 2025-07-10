defmodule TodoList.Repo.Migrations.UpdateTaskUserFkOnDelete do
  use Ecto.Migration

  def up do
    # First, drop the existing constraint.
    execute "ALTER TABLE tasks DROP CONSTRAINT IF EXISTS tasks_user_id_fkey"

    # Then, add a new constraint with ON DELETE RESTRICT
    alter table(:tasks) do
      modify :user_id, references(:users, on_delete: :restrict), null: false
    end
  end

  def down do
    # Revert to default ON DELETE behavior (usually :nothing)
    execute "ALTER TABLE tasks DROP CONSTRAINT IF EXISTS tasks_user_id_fkey"

    alter table(:tasks) do
      modify :user_id, references(:users, on_delete: :nothing), null: false
    end
  end
end
