defmodule Feast.Web.Plug.Authenticate do
  alias Plug.Conn
  alias Feast.Auth
  alias Feast.Auth.User

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    assign_current_user(conn)
  end

  defp assign_current_user(conn = %Conn{}) do
    assign_current_user(conn, Conn.get_session(conn, :current_user_id))
  end
  defp assign_current_user(conn, id) when is_integer(id) do
    assign_current_user(conn, Auth.get_user!(id))
  end
  defp assign_current_user(conn, user = %User{}) do
    Conn.assign(conn, :current_user, user)
  end
  defp assign_current_user(conn, _), do: redirect_to_sign_in(conn)

  defp redirect_to_sign_in(conn) do
    conn
    |> Phoenix.Controller.put_flash(
         :error,
         'You need to be signed in to view this page'
       )
    # TODO can't import dynamic route or we get import cycle
    |> Phoenix.Controller.redirect(to: "/auth/sessions/new")
    |> Conn.halt
  end
end
