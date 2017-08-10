defmodule Feast.Household do
  import Ecto.Query, warn: false

  alias Feast.Repo
  alias Feast.Household.Collective

  def list_collectives do
    Repo.all(Collective)
  end

  def has_household?(user_id) do
    case Repo.get_by(Collective, user_id: user_id) do
      {:ok, _} -> true
      _ -> false
    end
  end

  def get_collective!(id), do: Repo.get!(Collective, id)

  def create_collective(attrs \\ %{}) do
    %Collective{}
    |> Collective.changeset(attrs)
    |> Repo.insert()
  end

  def update_collective(%Collective{} = collective, attrs) do
    collective
    |> Collective.changeset(attrs)
    |> Repo.update()
  end

  def delete_collective(%Collective{} = collective) do
    Repo.delete(collective)
  end

  def change_collective(%Collective{} = collective) do
    Collective.changeset(collective, %{})
  end

  alias Feast.Household.Plan

  def list_plans do
    Repo.all(Plan)
  end

  def get_plan!(id), do: Repo.get!(Plan, id)

  def create_plan(attrs \\ %{}) do
    %Plan{}
    |> Plan.changeset(attrs)
    |> Repo.insert()
  end

  def update_plan(%Plan{} = plan, attrs) do
    plan
    |> Plan.changeset(attrs)
    |> Repo.update()
  end

  def delete_plan(%Plan{} = plan) do
    Repo.delete(plan)
  end

  def change_plan(%Plan{} = plan) do
    Plan.changeset(plan, %{})
  end
end
