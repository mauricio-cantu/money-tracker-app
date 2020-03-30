defmodule MoneyTracker.WebTest do
  use MoneyTracker.DataCase

  alias MoneyTracker.Web

  describe "accounts" do
    alias MoneyTracker.Web.Account

    @valid_attrs %{balance: 100, title: "some title"}
    @update_attrs %{balance: 200, title: "some updated title"}
    @invalid_attrs %{balance: nil, title: nil}
    @transaction_values %{below_minimum: 0, above_balance: 500, acceptable: 50}
    @deposit_values %{acceptable: 100, below_minimum: 0}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Web.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Web.get_account(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Web.create_account(@valid_attrs)
      assert Decimal.equal?(account.balance, 100)
      assert account.title == "some title"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = Web.update_account(account, @update_attrs)
      assert Decimal.equal?(account.balance, 200)
      assert account.title == "some updated title"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_account(account, @invalid_attrs)
      assert account == Web.get_account(account.id)
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Web.change_account(account)
    end

    test "create_transaction with valid data" do
      account_from = account_fixture()
      account_to = account_fixture()

      assert {:ok, "Transaction done succesfully."} ==
               Web.create_transaction(
                 account_from.id,
                 account_to.id,
                 @transaction_values.acceptable
               )
    end

    test "create_transaction with value greater than the origin account balance" do
      account_from = account_fixture()
      account_to = account_fixture()

      assert {:error, "Not enough money to complete the transaction."} ==
               Web.create_transaction(
                 account_from.id,
                 account_to.id,
                 @transaction_values.above_balance
               )
    end

    test "create_transaction with value below than minimum" do
      account_from = account_fixture()
      account_to = account_fixture()

      assert {:error, "Transactions minimum value is R$ 1,00."} ==
               Web.create_transaction(
                 account_from.id,
                 account_to.id,
                 @transaction_values.below_minimum
               )
    end

    test "create_transaction with unexisting accounts" do
      account_from_id = 0
      account_to = account_fixture()

      assert {:error, "Account not found."} ==
               Web.create_transaction(
                 account_from_id,
                 account_to.id,
                 @transaction_values.acceptable
               )
    end

    test "create_deposit with valid data" do
      account = account_fixture()

      assert {:ok, "Deposit done successfully."} ==
               Web.create_deposit(account, @deposit_values.acceptable)
    end

    test "create_deposit with value below than minimum" do
      account = account_fixture()

      assert {:error, "Deposits minimum value is R$ 1,00."} ==
               Web.create_deposit(account, @deposit_values.below_minimum)
    end

    test "create_deposit to unexisting account" do
      account = nil

      assert {:error, "Account not found."} ==
               Web.create_deposit(account, @deposit_values.acceptable)
    end
  end
end
