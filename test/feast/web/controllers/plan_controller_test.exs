defmodule Feast.Web.PlanControllerTest do
  use Feast.Web.ConnCase

  alias Feast.Household

  @create_attrs %{week: 42}
  @update_attrs %{week: 43}
  @invalid_attrs %{week: nil}

  def fixture(:plan) do
    {:ok, plan} = Household.create_plan(@create_attrs)
    plan
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, plan_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Plans"
  end

  test "renders form for new plans", %{conn: conn} do
    conn = get conn, plan_path(conn, :new)
    assert html_response(conn, 200) =~ "New Plan"
  end

  test "creates plan and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, plan_path(conn, :create), plan: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == plan_path(conn, :show, id)

    conn = get conn, plan_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Plan"
  end

  test "does not create plan and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, plan_path(conn, :create), plan: @invalid_attrs
    assert html_response(conn, 200) =~ "New Plan"
  end

  test "renders form for editing chosen plan", %{conn: conn} do
    plan = fixture(:plan)
    conn = get conn, plan_path(conn, :edit, plan)
    assert html_response(conn, 200) =~ "Edit Plan"
  end

  test "updates chosen plan and redirects when data is valid", %{conn: conn} do
    plan = fixture(:plan)
    conn = put conn, plan_path(conn, :update, plan), plan: @update_attrs
    assert redirected_to(conn) == plan_path(conn, :show, plan)

    conn = get conn, plan_path(conn, :show, plan)
    assert html_response(conn, 200)
  end

  test "does not update chosen plan and renders errors when data is invalid", %{conn: conn} do
    plan = fixture(:plan)
    conn = put conn, plan_path(conn, :update, plan), plan: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Plan"
  end

  test "deletes chosen plan", %{conn: conn} do
    plan = fixture(:plan)
    conn = delete conn, plan_path(conn, :delete, plan)
    assert redirected_to(conn) == plan_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, plan_path(conn, :show, plan)
    end
  end
end
