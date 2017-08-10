defmodule Feast.Repo.Migrations.FoodIngredients do
  use Ecto.Migration

  def change do
    create table(:food_ingredients) do
      add :name,          :string,            null: false
      add :price,         :integer
      add :unit,          :string

      timestamps()
    end
  end
end
