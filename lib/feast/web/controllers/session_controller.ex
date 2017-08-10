defmodule Feast.Web.SessionController do
  use Feast.Web, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Feast.Auth
  alias Feast.Auth.User

  plug :scrub_params, "user" when action in [:create]

  defp failed_login(conn) do
    dummy_checkpw()
    conn
    |> put_session(:current_user_id, nil)
    |> put_flash(:error, "Invalid username/password combination!")
    |> redirect(to: session_path(conn, :new))
    |> halt()
  end

  defp sign_in(user, _password, conn) when is_nil(user) do
    failed_login(conn)
  end

  defp sign_in(user, password, conn) do
    if checkpw(password, user.password_hash) do
      conn
      |> put_session(:current_user_id, user.id)
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: dash_path(conn, :index))
    else
      failed_login(conn)
    end
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: User.registration_changeset(%User{})
  end

  def create(conn, %{
    "user" => %{
      "email" => email,
      "password" => password}})
  when not is_nil(email) and not is_nil(password) do
    user = Auth.get_user_by!(email: email)
    sign_in(user, password, conn)
  end

  def create(conn, _) do
    failed_login(conn)
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> delete_session(:current_user)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: session_path(conn, :new))
  end
end