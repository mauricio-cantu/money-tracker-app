defmodule MoneyTrackerWeb.TransationControllerTest do
  use MoneyTrackerWeb.ConnCase

  alias MoneyTracker.Web
  alias MoneyTracker.Web.Account

  @create_attrs %{
    balance: 100,
    title: "some title"
  }

  @transactions_route "/transactions"

  def fixture do
    {:ok, account} = Web.create_account(@create_attrs)
    account
  end

  describe "create transaction" do
    test "create transaction when data is valid", %{conn: conn} do
      account_from = fixture()
      account_to = fixture()

      conn =
        post(conn, @transactions_route, %{
          "id_from" => account_from.id,
          "id_to" => account_to.id,
          "value" => 50
        })

      assert response(conn, 201)
    end

    test "create transaction when one of the accounts doesn't exist", %{conn: conn} do
      account_to = fixture()

      conn =
        post(conn, @transactions_route, %{
          "id_from" => 0,
          "id_to" => account_to.id,
          "value" => 50
        })

      assert response(conn, 422)
    end

    test "create transaction with value greater then the origin account balance", %{conn: conn} do
      account_from = fixture()
      account_to = fixture()

      conn =
        post(conn, @transactions_route, %{
          "id_from" => account_from.id,
          "id_to" => account_to.id,
          "value" => 1000
        })

      assert response(conn, 422)
    end

    test "create transaction with value lower than minimum required", %{conn: conn} do
      account_from = fixture()
      account_to = fixture()

      conn =
        post(conn, @transactions_route, %{
          "id_from" => account_from.id,
          "id_to" => account_to.id,
          "value" => 0
        })

      assert response(conn, 422)
    end

    test "create transaction between same accounts", %{conn: conn} do
      account_from = fixture()

      conn =
        post(conn, @transactions_route, %{
          "id_from" => account_from.id,
          "id_to" => account_from.id,
          "value" => 100
        })

      assert response(conn, 422)
    end
  end
end
