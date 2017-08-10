defmodule Feast.Auth do
  @moduledoc """
  The boundary for the Auth system.
  """

  import Ecto.Query, warn: false

  alias Feast.Repo
  alias Feast.Auth.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by!(query), do: Repo.get_by!(User, query)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user!(id) do
    get_user!(id)
    |> Repo.delete!
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
