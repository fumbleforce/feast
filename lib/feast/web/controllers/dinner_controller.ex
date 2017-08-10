defmodule Feast.Web.DinnerController do
  use Feast.Web, :controller

  alias Feast.Food

  def index(conn, _params) do
    dinners = Food.list_dinners()
    render(conn, "index.html", dinners: dinners)
  end

  def new(conn, _params) do
    changeset = Food.change_dinner(%Feast.Food.Dinner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"dinner" => dinner_params}) do
    case Food.create_dinner(dinner_params) do
      {:ok, dinner} ->
        conn
        |> put_flash(:info, "Dinner created successfully.")
        |> redirect(to: dinner_path(conn, :show, dinner))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    dinner = Food.get_dinner!(id)
    render(conn, "show.html", dinner: dinner)
  end

  def edit(conn, %{"id" => id}) do
    dinner = Food.get_dinner!(id)
    changeset = Food.change_dinner(dinner)
    render(conn, "edit.html", dinner: dinner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "dinner" => dinner_params}) do
    dinner = Food.get_dinner!(id)

    case Food.update_dinner(dinner, dinner_params) do
      {:ok, dinner} ->
        conn
        |> put_flash(:info, "Dinner updated successfully.")
        |> redirect(to: dinner_path(conn, :show, dinner))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", dinner: dinner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dinner = Food.get_dinner!(id)
    {:ok, _dinner} = Food.delete_dinner(dinner)

    conn
    |> put_flash(:info, "Dinner deleted successfully.")
    |> redirect(to: dinner_path(conn, :index))
  end
end
