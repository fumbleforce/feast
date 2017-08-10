defmodule Feast.Web.PlanController do
  use Feast.Web, :controller

  alias Feast.Household

  def index(conn, _params) do
    plans = Household.list_plans()
    render(conn, "index.html", plans: plans)
  end

  def new(conn, _params) do
    changeset = Household.change_plan(%Feast.Household.Plan{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"plan" => plan_params}) do
    case Household.create_plan(plan_params) do
      {:ok, plan} ->
        conn
        |> put_flash(:info, "Plan created successfully.")
        |> redirect(to: plan_path(conn, :show, plan))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    plan = Household.get_plan!(id)
    render(conn, "show.html", plan: plan)
  end

  def edit(conn, %{"id" => id}) do
    plan = Household.get_plan!(id)
    changeset = Household.change_plan(plan)
    render(conn, "edit.html", plan: plan, changeset: changeset)
  end

  def update(conn, %{"id" => id, "plan" => plan_params}) do
    plan = Household.get_plan!(id)

    case Household.update_plan(plan, plan_params) do
      {:ok, plan} ->
        conn
        |> put_flash(:info, "Plan updated successfully.")
        |> redirect(to: plan_path(conn, :show, plan))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", plan: plan, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    plan = Household.get_plan!(id)
    {:ok, _plan} = Household.delete_plan(plan)

    conn
    |> put_flash(:info, "Plan deleted successfully.")
    |> redirect(to: plan_path(conn, :index))
  end
end
