defmodule Feast.Household.Plan do
  use Ecto.Schema
  import Ecto.Changeset
  alias Feast.Household.Plan


  schema "household_plans" do
    field :week, :integer

    belongs_to :collective, Household.Collective

    has_one :dinner_1, Food.Dinner
    has_one :dinner_2, Food.Dinner
    has_one :dinner_3, Food.Dinner
    has_one :dinner_4, Food.Dinner
    has_one :dinner_5, Food.Dinner
    has_one :dinner_6, Food.Dinner
    has_one :dinner_7, Food.Dinner

    timestamps()
  end

  @doc false
  def changeset(%Plan{} = plan, attrs) do
    plan
    |> cast(attrs, [:week])
    |> validate_required([:week])
  end
end
