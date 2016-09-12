defmodule Harry do
  def price(items) do
    price(0,items)
  end

  def price(acc, items={n, j, k, l, m}) do
    distinct_books = Tuple.to_list(items)
    |> Enum.filter(fn (e) -> e > 0 end)
    |> Enum.count

    # distinct_books = Enum.reduce Tuple.to_list(items), 0 , positive

    if distinct_books == 0 do
      acc
    else
      acc + price(n * 8 * (1 - discounts(distinct_books)), {n-1, j-1, k-1, l-1, m-1})
    end 
  end

  def count_positive(item, acc) do
    if item > 0, do: acc + 1, else: acc
  end

  def discounts(n) do
    %{
      1 => 0,
      2 => 0.05,
      3 => 0.10,
      4 => 0.15,
      5 => 0.20
    }[n]
  end

end

defmodule HarryTest do
  use ExUnit.Case
  doctest Harry

  test "1 book" do
    assert Harry.price(0, {1, 0, 0, 0, 0}) == 8
  end

  test "2 different books" do
    assert Harry.price({1, 1, 0, 0, 0}) == 15.20
  end

  test "3 books one different" do
    assert Harry.price({2, 1, 0, 0, 0}) == 23.20
  end

  test "3 different books" do
    assert Harry.price({1, 1, 1, 0, 0}) == 21.60
  end

  test "4 different books" do
    assert Harry.price({1, 1, 1, 1, 0}) == (4*8)*0.85
  end

  test "5 different books" do
    assert Harry.price({1, 1, 1, 1, 1}) == (5*8)*0.80
  end

  # test "all together now" do
  #   assert Harry.price({5, 4, 3, 2, 1}) == (
  #     (5 * 8 * 80) 
  #     + (4 * 8 * 85) 
  #     + (3 * 8 * 90) 
  #     + (2 * 8 * 95) 
  #     + 800) /100
  # end

end
