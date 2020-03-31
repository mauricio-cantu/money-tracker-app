defmodule MoneyTracker.Web do
  @moduledoc """
  The Web context.
  """

  import Ecto.Query, warn: false
  alias MoneyTracker.Repo

  alias MoneyTracker.Web.Account

  @doc """
  Returns the list of accounts.
  """
  def list_accounts do
    Repo.all(Account)
  end

  @doc """
  Gets a single account.
  """
  def get_account(id), do: Repo.get(Account, id)

  @doc """
  Creates a account.
  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.
  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account.
  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.
  """
  def change_account(%Account{} = account) do
    Account.changeset(account, %{})
  end

  @doc """
  Performs a transaction between two accounts.
  """
  def create_transaction(id_from, id_to, value) do
    account_from = get_account(id_from)
    account_to = get_account(id_to)

    if account_from == nil || account_to == nil do
      {:error, "Account not found."}
    else
      if account_from == account_to do
        {:error, "Origin account is the same that the destination account."}
      else
        if Decimal.lt?(value, 1) do
          {:error, "Transactions minimum value is R$ 1,00."}
        else
          if Decimal.gt?(account_from.balance, value) do
            update_account(account_from, %{"balance" => Decimal.sub(account_from.balance, value)})
            update_account(account_to, %{"balance" => Decimal.add(account_to.balance, value)})
            {:ok, "Transaction done succesfully."}
          else
            {:error, "Not enough money to complete the transaction."}
          end
        end
      end
    end
  end

  @doc """
  Performs a deposit to a specific account.
  """
  def create_deposit(%Account{} = account, value) do
    if Decimal.lt?(value, 1) do
      {:error, "Deposits minimum value is R$ 1,00."}
    else
      update_account(account, %{"balance" => Decimal.add(account.balance, value)})
      {:ok, "Deposit done successfully."}
    end
  end

  @doc """
  In case the given account is an unexisting one, returns an error.
  """
  def create_deposit(nil, _value), do: {:error, "Account not found."}
end
