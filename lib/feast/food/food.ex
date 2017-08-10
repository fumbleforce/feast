defmodule Feast.Food do
  @moduledoc """
  The boundary for the Food system.
  """

  import Ecto.Query, warn: false
  alias Feast.Repo

  alias Feast.Food.Dinner

  @doc """
  Returns the list of dinners.

  ## Examples

      iex> list_dinners()
      [%Dinner{}, ...]

  """
  def list_dinners do
    Repo.all(Dinner)
  end

  @doc """
  Gets a single dinner.

  Raises `Ecto.NoResultsError` if the Dinner does not exist.

  ## Examples

      iex> get_dinner!(123)
      %Dinner{}

      iex> get_dinner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dinner!(id), do: Repo.get!(Dinner, id)

  @doc """
  Creates a dinner.

  ## Examples

      iex> create_dinner(%{field: value})
      {:ok, %Dinner{}}

      iex> create_dinner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dinner(attrs \\ %{}) do
    %Dinner{}
    |> Dinner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dinner.

  ## Examples

      iex> update_dinner(dinner, %{field: new_value})
      {:ok, %Dinner{}}

      iex> update_dinner(dinner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dinner(%Dinner{} = dinner, attrs) do
    dinner
    |> Dinner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Dinner.

  ## Examples

      iex> delete_dinner(dinner)
      {:ok, %Dinner{}}

      iex> delete_dinner(dinner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dinner(%Dinner{} = dinner) do
    Repo.delete(dinner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dinner changes.

  ## Examples

      iex> change_dinner(dinner)
      %Ecto.Changeset{source: %Dinner{}}

  """
  def change_dinner(%Dinner{} = dinner) do
    Dinner.changeset(dinner, %{})
  end

  alias Feast.Food.Ingredient

  @doc """
  Returns the list of ingredients.

  ## Examples

      iex> list_ingredients()
      [%Ingredient{}, ...]

  """
  def list_ingredients do
    Repo.all(Ingredient)
  end

  @doc """
  Gets a single ingredient.

  Raises `Ecto.NoResultsError` if the Ingredient does not exist.

  ## Examples

      iex> get_ingredient!(123)
      %Ingredient{}

      iex> get_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient!(id), do: Repo.get!(Ingredient, id)

  @doc """
  Creates a ingredient.

  ## Examples

      iex> create_ingredient(%{field: value})
      {:ok, %Ingredient{}}

      iex> create_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient(attrs \\ %{}) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ingredient.

  ## Examples

      iex> update_ingredient(ingredient, %{field: new_value})
      {:ok, %Ingredient{}}

      iex> update_ingredient(ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> Ingredient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ingredient.

  ## Examples

      iex> delete_ingredient(ingredient)
      {:ok, %Ingredient{}}

      iex> delete_ingredient(ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient(%Ingredient{} = ingredient) do
    Repo.delete(ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient changes.

  ## Examples

      iex> change_ingredient(ingredient)
      %Ecto.Changeset{source: %Ingredient{}}

  """
  def change_ingredient(%Ingredient{} = ingredient) do
    Ingredient.changeset(ingredient, %{})
  end
end
