defmodule Feast.Web.CollectiveController do
  use Feast.Web, :controller

  alias Feast.Household

  def index(conn, _params) do
    collectives = Household.list_collectives()
    render(conn, "index.html", collectives: collectives)
  end

  def new(conn, _params) do
    changeset = Household.change_collective(%Feast.Household.Collective{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"collective" => collective_params}) do
    case Household.create_collective(collective_params) do
      {:ok, collective} ->
        conn
        |> put_flash(:info, "Collective created successfully.")
        |> redirect(to: collective_path(conn, :show, collective))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    collective = Household.get_collective!(id)
    render(conn, "show.html", collective: collective)
  end

  def edit(conn, %{"id" => id}) do
    collective = Household.get_collective!(id)
    changeset = Household.change_collective(collective)
    render(conn, "edit.html", collective: collective, changeset: changeset)
  end

  def update(conn, %{"id" => id, "collective" => collective_params}) do
    collective = Household.get_collective!(id)

    case Household.update_collective(collective, collective_params) do
      {:ok, collective} ->
        conn
        |> put_flash(:info, "Collective updated successfully.")
        |> redirect(to: collective_path(conn, :show, collective))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", collective: collective, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    collective = Household.get_collective!(id)
    {:ok, _collective} = Household.delete_collective(collective)

    conn
    |> put_flash(:info, "Collective deleted successfully.")
    |> redirect(to: collective_path(conn, :index))
  end
end
