defmodule MoneyTrackerWeb.TransactionController do
  use MoneyTrackerWeb, :controller

  alias MoneyTracker.Web

  @doc """
  Tries to perform the transaction and returns a response
  """
  def create(conn, %{"id_from" => id_from, "id_to" => id_to, "value" => value}) do
    put_resp_content_type(conn, "application/json")

    case Web.create_transaction(id_from, id_to, value) do
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
