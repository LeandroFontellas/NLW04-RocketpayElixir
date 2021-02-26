defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true
  alias RocketpayWeb.UsersView

  import Phoenix.View
  alias Rocketpay.{User, Account}


  test "it should be able to render create.json" do
    params = %{
      name: "Leandro",
      password: "123456",
      nickname: "Fontellas",
      email: "leandro@example123.com",
      age: 24
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{message: "User created", user: %{
      account: %{
      balance: Decimal.new("0.00"),
      id: account_id
      },
      id: user_id,
      name: "Leandro",
      nickname: "Fontellas"
      }}

    assert expected_response == response
  end
end
