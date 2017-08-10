defmodule Feast.Web.DinnerControllerTest do
  use Feast.Web.ConnCase

  alias Feast.Food

  @create_attrs %{description: "some description", difficulty: 42, name: "some name", recipe: "some recipe", time: 42}
  @update_attrs %{description: "some updated description", difficulty: 43, name: "some updated name", recipe: "some updated recipe", time: 43}
  @invalid_attrs %{description: nil, difficulty: nil, name: nil, recipe: nil, time: nil}

  def fixture(:dinner) do
    {:ok, dinner} = Food.create_dinner(@create_attrs)
    dinner
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, dinner_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Dinners"
  end

  test "renders form for new dinners", %{conn: conn} do
    conn = get conn, dinner_path(conn, :new)
    assert html_response(conn, 200) =~ "New Dinner"
  end

  test "creates dinner and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, dinner_path(conn, :create), dinner: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == dinner_path(conn, :show, id)

    conn = get conn, dinner_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Dinner"
  end

  test "does not create dinner and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, dinner_path(conn, :create), dinner: @invalid_attrs
    assert html_response(conn, 200) =~ "New Dinner"
  end

  test "renders form for editing chosen dinner", %{conn: conn} do
    dinner = fixture(:dinner)
    conn = get conn, dinner_path(conn, :edit, dinner)
    assert html_response(conn, 200) =~ "Edit Dinner"
  end

  test "updates chosen dinner and redirects when data is valid", %{conn: conn} do
    dinner = fixture(:dinner)
    conn = put conn, dinner_path(conn, :update, dinner), dinner: @update_attrs
    assert redirected_to(conn) == dinner_path(conn, :show, dinner)

    conn = get conn, dinner_path(conn, :show, dinner)
    assert html_response(conn, 200) =~ "some updated description"
  end

  test "does not update chosen dinner and renders errors when data is invalid", %{conn: conn} do
    dinner = fixture(:dinner)
    conn = put conn, dinner_path(conn, :update, dinner), dinner: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Dinner"
  end

  test "deletes chosen dinner", %{conn: conn} do
    dinner = fixture(:dinner)
    conn = delete conn, dinner_path(conn, :delete, dinner)
    assert redirected_to(conn) == dinner_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, dinner_path(conn, :show, dinner)
    end
  end
end
