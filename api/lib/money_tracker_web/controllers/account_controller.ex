defmodule MoneyTrackerWeb.AccountController do
  use MoneyTrackerWeb, :controller

  alias MoneyTracker.Web
  alias MoneyTracker.Web.Account

  @doc """
  Returns an account list.
  """
  def index(conn, _params) do
    accounts = Web.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  @doc """
  Creates an account.
  """
  def create(conn, %{"account" => account_params}) do
    case Web.create_account(account_params) do
      {:ok, %Account{} = account} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.account_path(conn, :show, account))
        |> render("show.json", account: account)

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{message: "Invalid information."})
    end
  end

  @doc """
  Returns an account with given id.
  """
  def show(conn, %{"id" => id}) do
    account = Web.get_account(id)

    if account == nil do
      conn
      |> put_status(:not_found)
      |> json(%{message: "Account not found."})
    else
      render(conn, "show.json", account: account)
    end
  end

  @doc """
  Updates the account with given id.
  """
  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Web.get_account(id)

    case Web.update_account(account, account_params) do
      {:ok, %Account{} = account} ->
        render(conn, "show.json", account: account)

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{message: "Invalid information."})
    end
  end

  @doc """
  Deletes account with given id.
  """
  def delete(conn, %{"id" => id}) do
    account = Web.get_account(id)

    with {:ok, %Account{}} <- Web.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
