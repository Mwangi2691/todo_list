defmodule TodoList.Repo.Migrations.AddPriorityToTasks do
  use Ecto.Migration

  def change do
alter table (:tasks) do
  add :priority, :string , null: false, default:
  "normal"
end
  end
end
