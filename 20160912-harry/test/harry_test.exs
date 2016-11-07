defmodule Harry do
  def price(items) when is_tuple(items) do
    Tuple.to_list(items)
    |> price
  end

  def price(items) do
    price(0, items)
  end

  def price(amount, [0, 0, 0, 0, 0]) do
    amount
  end

  def price(amount, items) do
    {distinct_books, new_items} = count_positive_and_decrement(items)
    new_amount = amount + distinct_books * 8 * discount(distinct_books)
    price(new_amount, new_items)
  end

  [0, 0.05, 0.10, 0.15, 0.20]
  |> Enum.with_index(1)
  |> Enum.map(fn ({val, n}) ->
    def discount(unquote(n)) do
      1 - unquote(val)
    end
  end)

  def count_positive_and_decrement(items) do
    items
    |> Enum.reduce({0, []}, fn (item, {positive, new_items}) ->
      {positive, new_item} = if item > 0, do: {positive + 1, item - 1}, else: {positive, item}
      {positive, new_items ++ [new_item]}
    end)
  end
end

defmodule HarryTest do
  use ExUnit.Case
  doctest Harry

  test "1 book" do
    assert Harry.price({1, 0, 0, 0, 0}) == 8
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

  test "all together now" do
    assert Harry.price({5, 4, 3, 2, 1}) == [
      (5 * 8 * 0.80),
      (4 * 8 * 0.85),
      (3 * 8 * 0.90),
      (2 * 8 * 0.95),
      8]
      |> Enum.sum
  end

end
