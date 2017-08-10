defmodule Feast.Web.AuthHelpers do
  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def signed_in?(conn), do: !!current_user(conn)
end