defmodule Feast.Household.Collective do
  use Ecto.Schema
  import Ecto.Changeset
  alias Feast.Household.Collective


  schema "household_collectives" do
    field :name,    :string
    field :members, :integer,   default: 1

    belongs_to      :user,      Auth.User

    timestamps()
  end

  @doc false
  def changeset(%Collective{} = collective, attrs) do
    collective
    |> cast(attrs, [:name, :members])
    |> validate_required([:name, :members])
  end
end
