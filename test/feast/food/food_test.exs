defmodule Feast.FoodTest do
  use Feast.DataCase

  alias Feast.Food

  describe "dinners" do
    alias Feast.Food.Dinner

    @valid_attrs %{description: "some description", difficulty: 42, name: "some name", recipe: "some recipe", time: 42}
    @update_attrs %{description: "some updated description", difficulty: 43, name: "some updated name", recipe: "some updated recipe", time: 43}
    @invalid_attrs %{description: nil, difficulty: nil, name: nil, recipe: nil, time: nil}

    def dinner_fixture(attrs \\ %{}) do
      {:ok, dinner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Food.create_dinner()

      dinner
    end

    test "list_dinners/0 returns all dinners" do
      dinner = dinner_fixture()
      assert Food.list_dinners() == [dinner]
    end

    test "get_dinner!/1 returns the dinner with given id" do
      dinner = dinner_fixture()
      assert Food.get_dinner!(dinner.id) == dinner
    end

    test "create_dinner/1 with valid data creates a dinner" do
      assert {:ok, %Dinner{} = dinner} = Food.create_dinner(@valid_attrs)
      assert dinner.description == "some description"
      assert dinner.difficulty == 42
      assert dinner.name == "some name"
      assert dinner.recipe == "some recipe"
      assert dinner.time == 42
    end

    test "create_dinner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Food.create_dinner(@invalid_attrs)
    end

    test "update_dinner/2 with valid data updates the dinner" do
      dinner = dinner_fixture()
      assert {:ok, dinner} = Food.update_dinner(dinner, @update_attrs)
      assert %Dinner{} = dinner
      assert dinner.description == "some updated description"
      assert dinner.difficulty == 43
      assert dinner.name == "some updated name"
      assert dinner.recipe == "some updated recipe"
      assert dinner.time == 43
    end

    test "update_dinner/2 with invalid data returns error changeset" do
      dinner = dinner_fixture()
      assert {:error, %Ecto.Changeset{}} = Food.update_dinner(dinner, @invalid_attrs)
      assert dinner == Food.get_dinner!(dinner.id)
    end

    test "delete_dinner/1 deletes the dinner" do
      dinner = dinner_fixture()
      assert {:ok, %Dinner{}} = Food.delete_dinner(dinner)
      assert_raise Ecto.NoResultsError, fn -> Food.get_dinner!(dinner.id) end
    end

    test "change_dinner/1 returns a dinner changeset" do
      dinner = dinner_fixture()
      assert %Ecto.Changeset{} = Food.change_dinner(dinner)
    end
  end

  describe "ingredients" do
    alias Feast.Food.Ingredient

    @valid_attrs %{name: "some name", price: 42, unit: "some unit"}
    @update_attrs %{name: "some updated name", price: 43, unit: "some updated unit"}
    @invalid_attrs %{name: nil, price: nil, unit: nil}

    def ingredient_fixture(attrs \\ %{}) do
      {:ok, ingredient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Food.create_ingredient()

      ingredient
    end

    test "list_ingredients/0 returns all ingredients" do
      ingredient = ingredient_fixture()
      assert Food.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = ingredient_fixture()
      assert Food.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      assert {:ok, %Ingredient{} = ingredient} = Food.create_ingredient(@valid_attrs)
      assert ingredient.name == "some name"
      assert ingredient.price == 42
      assert ingredient.unit == "some unit"
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Food.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, ingredient} = Food.update_ingredient(ingredient, @update_attrs)
      assert %Ingredient{} = ingredient
      assert ingredient.name == "some updated name"
      assert ingredient.price == 43
      assert ingredient.unit == "some updated unit"
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Food.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Food.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{}} = Food.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Food.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = ingredient_fixture()
      assert %Ecto.Changeset{} = Food.change_ingredient(ingredient)
    end
  end
end
