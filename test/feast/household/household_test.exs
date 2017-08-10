defmodule Feast.HouseholdTest do
  use Feast.DataCase

  alias Feast.Household

  describe "collectives" do
    alias Feast.Household.Collective

    @valid_attrs %{members: 42, name: "some name"}
    @update_attrs %{members: 43, name: "some updated name"}
    @invalid_attrs %{members: nil, name: nil}

    def collective_fixture(attrs \\ %{}) do
      {:ok, collective} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Household.create_collective()

      collective
    end

    test "list_collectives/0 returns all collectives" do
      collective = collective_fixture()
      assert Household.list_collectives() == [collective]
    end

    test "get_collective!/1 returns the collective with given id" do
      collective = collective_fixture()
      assert Household.get_collective!(collective.id) == collective
    end

    test "create_collective/1 with valid data creates a collective" do
      assert {:ok, %Collective{} = collective} = Household.create_collective(@valid_attrs)
      assert collective.members == 42
      assert collective.name == "some name"
    end

    test "create_collective/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Household.create_collective(@invalid_attrs)
    end

    test "update_collective/2 with valid data updates the collective" do
      collective = collective_fixture()
      assert {:ok, collective} = Household.update_collective(collective, @update_attrs)
      assert %Collective{} = collective
      assert collective.members == 43
      assert collective.name == "some updated name"
    end

    test "update_collective/2 with invalid data returns error changeset" do
      collective = collective_fixture()
      assert {:error, %Ecto.Changeset{}} = Household.update_collective(collective, @invalid_attrs)
      assert collective == Household.get_collective!(collective.id)
    end

    test "delete_collective/1 deletes the collective" do
      collective = collective_fixture()
      assert {:ok, %Collective{}} = Household.delete_collective(collective)
      assert_raise Ecto.NoResultsError, fn -> Household.get_collective!(collective.id) end
    end

    test "change_collective/1 returns a collective changeset" do
      collective = collective_fixture()
      assert %Ecto.Changeset{} = Household.change_collective(collective)
    end
  end

  describe "plans" do
    alias Feast.Household.Plan

    @valid_attrs %{week: 42}
    @update_attrs %{week: 43}
    @invalid_attrs %{week: nil}

    def plan_fixture(attrs \\ %{}) do
      {:ok, plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Household.create_plan()

      plan
    end

    test "list_plans/0 returns all plans" do
      plan = plan_fixture()
      assert Household.list_plans() == [plan]
    end

    test "get_plan!/1 returns the plan with given id" do
      plan = plan_fixture()
      assert Household.get_plan!(plan.id) == plan
    end

    test "create_plan/1 with valid data creates a plan" do
      assert {:ok, %Plan{} = plan} = Household.create_plan(@valid_attrs)
      assert plan.week == 42
    end

    test "create_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Household.create_plan(@invalid_attrs)
    end

    test "update_plan/2 with valid data updates the plan" do
      plan = plan_fixture()
      assert {:ok, plan} = Household.update_plan(plan, @update_attrs)
      assert %Plan{} = plan
      assert plan.week == 43
    end

    test "update_plan/2 with invalid data returns error changeset" do
      plan = plan_fixture()
      assert {:error, %Ecto.Changeset{}} = Household.update_plan(plan, @invalid_attrs)
      assert plan == Household.get_plan!(plan.id)
    end

    test "delete_plan/1 deletes the plan" do
      plan = plan_fixture()
      assert {:ok, %Plan{}} = Household.delete_plan(plan)
      assert_raise Ecto.NoResultsError, fn -> Household.get_plan!(plan.id) end
    end

    test "change_plan/1 returns a plan changeset" do
      plan = plan_fixture()
      assert %Ecto.Changeset{} = Household.change_plan(plan)
    end
  end
end
