defmodule MoneyTracker.Repo do
  use Ecto.Repo,
    otp_app: :money_tracker,
    adapter: Ecto.Adapters.MyXQL
end
