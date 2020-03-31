defmodule MoneyTrackerWeb.DepositController do
  use MoneyTrackerWeb, :controller

  alias MoneyTracker.Web

  @doc """
  Tries to perform the deposit and returns a response
  """
  def create(conn, %{"id" => id, "value" => value}) do
    account = Web.get_account(id)

    case Web.create_deposit(account, value) do
      {:ok, message} ->
        conn
        |> put_status(:created)
        |> json(%{message: message})

      {:error, message} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{message: message})
    end
  end
end
