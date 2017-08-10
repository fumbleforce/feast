defmodule Feast.Web.IngredientController do
  use Feast.Web, :controller

  alias Feast.Food

  def index(conn, _params) do
    ingredients = Food.list_ingredients()
    render(conn, "index.html", ingredients: ingredients)
  end

  def new(conn, _params) do
    changeset = Food.change_ingredient(%Feast.Food.Ingredient{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ingredient" => ingredient_params}) do
    case Food.create_ingredient(ingredient_params) do
      {:ok, ingredient} ->
        conn
        |> put_flash(:info, "Ingredient created successfully.")
        |> redirect(to: ingredient_path(conn, :show, ingredient))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ingredient = Food.get_ingredient!(id)
    render(conn, "show.html", ingredient: ingredient)
  end

  def edit(conn, %{"id" => id}) do
    ingredient = Food.get_ingredient!(id)
    changeset = Food.change_ingredient(ingredient)
    render(conn, "edit.html", ingredient: ingredient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ingredient" => ingredient_params}) do
    ingredient = Food.get_ingredient!(id)

    case Food.update_ingredient(ingredient, ingredient_params) do
      {:ok, ingredient} ->
        conn
        |> put_flash(:info, "Ingredient updated successfully.")
        |> redirect(to: ingredient_path(conn, :show, ingredient))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ingredient: ingredient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ingredient = Food.get_ingredient!(id)
    {:ok, _ingredient} = Food.delete_ingredient(ingredient)

    conn
    |> put_flash(:info, "Ingredient deleted successfully.")
    |> redirect(to: ingredient_path(conn, :index))
  end
end
