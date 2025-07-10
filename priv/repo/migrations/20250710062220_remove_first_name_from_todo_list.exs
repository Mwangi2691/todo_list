defmodule TodoList.Repo.Migrations.RemoveFirstNameFromTodoList do
  use Ecto.Migration

  def change do
    alter table (:tasks) do
      remove :first_name
    end
  end
end
