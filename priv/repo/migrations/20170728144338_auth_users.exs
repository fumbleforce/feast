defmodule Feast.Repo.Migrations.AuthUsers do
  use Ecto.Migration

  def change do
    create table(:auth_users) do
      add :name,          :string
      add :email,         :string
      add :password_hash, :string

      timestamps()
    end
  end
end
