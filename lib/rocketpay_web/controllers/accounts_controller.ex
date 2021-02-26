defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account

  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback RocketpayWeb.FallbackController

  def deposit(connection, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      connection
    |> put_status(:ok)
    |> render("update.json", account: account)
    end
  end
  def withdraw(connection, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      connection
    |> put_status(:ok)
    |> render("update.json", account: account)
    end
  end
  def transaction(connection, params) do
    task = Task.async(fn -> Rocketpay.transaction(params) end)

    with {:ok, %TransactionResponse{} = transaction} <- Task.await(task) do
      connection
    |> put_status(:ok)
    |> render("transaction.json", transaction: transaction)
    end
  end
end
