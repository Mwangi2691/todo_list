defmodule TodoList.Repo.Migrations.AddFirstNameToTasks do
  use Ecto.Migration

  def change do
alter table (:tasks) do
  add :first_name, :string
end
  end
end
