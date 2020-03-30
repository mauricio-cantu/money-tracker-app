defmodule MoneyTracker.Repo.Migrations.AlterAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      modify :balance, :decimal
    end
  end
end
