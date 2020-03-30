defmodule MoneyTrackerWeb.Router do
  use MoneyTrackerWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/", MoneyTrackerWeb do
    pipe_through :api

    resources "/accounts", AccountController
    options "/accounts", AccountController, :options

    post "/transactions", TransactionController, :create
    post "/deposits", DepositController, :create
  end
end
