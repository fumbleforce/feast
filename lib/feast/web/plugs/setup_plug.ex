defmodule Feast.Web.Plug.Setup do
  alias Plug.Conn
  alias Feast.Web.AuthHelpers
  alias Feast.Household

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    check_has_setup(conn)
  end

  defp check_has_setup(conn = %Conn{}) do
    user = AuthHelpers.current_user(conn)
    has_household = Household.has_household?(user.id)

    if has_household do redirect_to_setup(conn) end
  end

  defp redirect_to_setup(conn) do
    conn
    |> Phoenix.Controller.redirect(to: "/collective/new")
    |> Conn.halt
  end
end
