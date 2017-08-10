defmodule Feast.Repo.Migrations.FoodDinners do
  use Ecto.Migration

  def change do
    create table(:food_dinners) do
      add :name,              :text, null: false
      add :difficulty,        :integer, default: 1
      add :description,       :text
      add :recipe,            :text

      add :user_id, references(:auth_users), null: false

      timestamps()
    end
  end
end
