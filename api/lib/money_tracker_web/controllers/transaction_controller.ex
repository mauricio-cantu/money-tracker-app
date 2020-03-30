defmodule MoneyTrackerWeb.TransactionController do
  use MoneyTrackerWeb, :controller

  alias MoneyTracker.Web

  @doc """
  Tries to perform the transaction and returns a response
  """
  def create(conn, %{"id_from" => id_from, "id_to" => id_to, "value" => value}) do
    conn |> put_resp_content_type("application/json")

    case Web.create_transaction(id_from, id_to, value) do
      {:ok, message} ->
        conn
        |> send_resp(:ok, Jason.encode!(%{message: message}))

      {:error, message} ->
        conn
        |> send_resp(:unprocessable_entity, Jason.encode!(%{message: message}))
    end
  end
end
