defmodule MoneyTrackerWeb.DepositControllerTest do
  use MoneyTrackerWeb.ConnCase

  alias MoneyTracker.Web
  alias MoneyTracker.Web.Account

  @create_attrs %{
    balance: 100,
    title: "some title"
  }

  @deposits_route "/deposits"

  def fixture do
    {:ok, account} = Web.create_account(@create_attrs)
    account
  end

  describe "create deposit" do
    test "create deposit when data is valid", %{conn: conn} do
      account = fixture()

      conn =
        post(conn, @deposits_route, %{
          "id" => account.id,
          "value" => 50
        })

      assert response(conn, 201)
    end

    test "create deposit to unexisting account", %{conn: conn} do
      conn =
        post(conn, @deposits_route, %{
          "id" => 0,
          "value" => 50
        })

      assert response(conn, 422)
    end

    test "create deposit with value lower than minimum required", %{conn: conn} do
      account = fixture()

      conn =
        post(conn, @deposits_route, %{
          "id" => account.id,
          "value" => 0
        })

      assert response(conn, 422)
    end
  end
end
