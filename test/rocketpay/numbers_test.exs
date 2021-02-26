defmodule Rocketpay.NumbersText do
  use ExUnit.Case, async: true

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "it should be able to sum the numbers from a file given its filename" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end
    test "it should not be able to sum the numbers from a file if the filename is incorrect or is not given" do
      response = Numbers.sum_from_file("banana")

      expected_response = {:error, %{message: "Invalid File"}}

      assert response == expected_response
    end
  end
end
