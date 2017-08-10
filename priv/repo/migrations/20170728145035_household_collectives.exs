defmodule Feast.Repo.Migrations.HouseholdCollectives do
  use Ecto.Migration

  def change do
    create table(:household_collectives) do
      add :name,          :string,  null: false
      add :members,       :integer, default: 1

      add :user_id, references(:auth_users), null: false

      timestamps()
    end
  end
end
