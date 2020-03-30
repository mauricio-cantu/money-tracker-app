defmodule MoneyTracker.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :title, :string
      add :balance, :string

      timestamps()
    end

  end
end
