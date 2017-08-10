defmodule Feast.Food.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Feast.Food.Ingredient


  schema "food_ingredients" do
    field :name, :string
    field :price, :integer
    field :unit, :string

    timestamps()
  end

  @doc false
  def changeset(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :price, :unit])
    |> validate_required([:name, :price, :unit])
  end
end
