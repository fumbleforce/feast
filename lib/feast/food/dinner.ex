defmodule Feast.Food.Dinner do
  use Ecto.Schema
  import Ecto.Changeset
  alias Feast.Food.Dinner


  schema "food_dinners" do
    field :description, :string
    field :difficulty, :integer
    field :name, :string
    field :recipe, :string
    field :time, :integer
    field :author_id, :id

    many_to_many :ingredients, Food.Ingredient, join_through: "dinners_ingredients"

    timestamps()
  end

  @doc false
  def changeset(%Dinner{} = dinner, attrs) do
    dinner
    |> cast(attrs, [:name, :difficulty, :time, :description, :recipe])
    |> validate_required([:name, :difficulty, :time, :description, :recipe])
  end
end
