defmodule MoneyTracker.Web.Account do
  @moduledoc """
  Account module.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :balance, :decimal
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:title, :balance])
    |> validate_required([:title, :balance])
  end
end
