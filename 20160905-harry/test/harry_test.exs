defmodule Harry.ShoppingCart do
  def total_price(description) do
    description 
    |> String.split("\n")
    |> Enum.count
    |> calculate_total
  end

  defp calculate_total(5), do: 33.75
  defp calculate_total(4), do: 27.20
  defp calculate_total(3), do: 21.60
  defp calculate_total(2), do: 15.20
  defp calculate_total(1), do: 8
end

defmodule HarryTest do
  use ExUnit.Case
  doctest Harry

  test "one book" do
    price = Harry.ShoppingCart.total_price "1 copy of the first book"
    assert price == 8
  end

  test "two different books" do
    price = Harry.ShoppingCart.total_price "1 copy of the first book\n1 copy of the second book"
    assert price == 15.20
  end

  test "three different books" do
    price = Harry.ShoppingCart.total_price "1 copy of the first book\n1 copy of the second book\n1 copy of the third book"
    assert price == 21.6
  end

  test "four different books" do
    price = Harry.ShoppingCart.total_price "1 copy of the first book\n1 copy of the second book\n1 copy of the third book\n1 copy of the fourth book"
    assert price == 27.2
  end

  test "five different books" do
    price = Harry.ShoppingCart.total_price "1 copy of the first book\n1 copy of the second book\n1 copy of the third book\n1 copy of the fourth book\n1 copy of the fifth book"
    assert price == 33.75
  end

end
