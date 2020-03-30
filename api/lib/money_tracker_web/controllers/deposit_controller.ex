defmodule MoneyTrackerWeb.DepositController do
  use MoneyTrackerWeb, :controller

  alias MoneyTracker.Web

  @doc """
  Tries to perform the deposit and returns a response
  """
  def create(conn, %{"id" => id, "value" => value}) do
    conn |> put_resp_header("content-type", "application/json; charset=utf-8")

    account = Web.get_account(id)

    case Web.create_deposit(account, value) do
      {:ok, message} ->
        conn
        |> send_resp(:ok, Jason.encode!(%{message: message}))

      {:error, message} ->
        conn
        |> send_resp(:unprocessable_entity, Jason.encode!(%{message: message}))
    end
  end
end
