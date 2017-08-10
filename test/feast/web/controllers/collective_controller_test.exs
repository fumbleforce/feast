defmodule Feast.Web.CollectiveControllerTest do
  use Feast.Web.ConnCase

  alias Feast.Household

  @create_attrs %{members: 42, name: "some name"}
  @update_attrs %{members: 43, name: "some updated name"}
  @invalid_attrs %{members: nil, name: nil}

  def fixture(:collective) do
    {:ok, collective} = Household.create_collective(@create_attrs)
    collective
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, collective_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Collectives"
  end

  test "renders form for new collectives", %{conn: conn} do
    conn = get conn, collective_path(conn, :new)
    assert html_response(conn, 200) =~ "New Collective"
  end

  test "creates collective and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, collective_path(conn, :create), collective: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == collective_path(conn, :show, id)

    conn = get conn, collective_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Collective"
  end

  test "does not create collective and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, collective_path(conn, :create), collective: @invalid_attrs
    assert html_response(conn, 200) =~ "New Collective"
  end

  test "renders form for editing chosen collective", %{conn: conn} do
    collective = fixture(:collective)
    conn = get conn, collective_path(conn, :edit, collective)
    assert html_response(conn, 200) =~ "Edit Collective"
  end

  test "updates chosen collective and redirects when data is valid", %{conn: conn} do
    collective = fixture(:collective)
    conn = put conn, collective_path(conn, :update, collective), collective: @update_attrs
    assert redirected_to(conn) == collective_path(conn, :show, collective)

    conn = get conn, collective_path(conn, :show, collective)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen collective and renders errors when data is invalid", %{conn: conn} do
    collective = fixture(:collective)
    conn = put conn, collective_path(conn, :update, collective), collective: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Collective"
  end

  test "deletes chosen collective", %{conn: conn} do
    collective = fixture(:collective)
    conn = delete conn, collective_path(conn, :delete, collective)
    assert redirected_to(conn) == collective_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, collective_path(conn, :show, collective)
    end
  end
end
