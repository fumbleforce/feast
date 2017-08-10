defmodule Feast.Auth.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  alias Feast.Auth.User

  schema "auth_users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string

    timestamps()

    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  def validate_email(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, email ->
      case Regex.match?(~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, email) do
          true -> []
          false -> [{field, options[:message] || "Email is not in a valid format."}]
        end
      end)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, [:name, :email, :password_hash,])
    |> validate_required([:name, :email])
    |> validate_length(:name, min: 2)
    |> validate_length(:password, min: 6)
    |> validate_email(:email)
    |> unique_constraint(:email)
  end

  def login_changeset(user, params) do
    user
    |> cast(params, [
      :email,
      :password_hash
      ])
  end

  def registration_changeset(user, params \\ %{}) do
    user
    |> cast(params, [
      :name,
      :email,
      :password,
      :password_confirmation])
    |> validate_required([
      :name,
      :email,
      :password,
      :password_confirmation])
    |> validate_email(:email)
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_hash, hashpwsalt(password))
      |> put_change(:password, nil)
      |> put_change(:password_confirmation, nil)
    else
      changeset
    end
  end
end
