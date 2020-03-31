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
        |> put_status(:created)
        |> json(%{message: message})

      # send_resp(conn, :ok, Jason.encode!(%{message: message}))

      {:error, message} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{message: message})

        # send_resp(conn, :unprocessable_entity, Jason.encode!(%{message: message}))
    end
  end
end
