defmodule Harry do

  def price({0, 0, 0, 0, 0}) do
    0
  end

  def price({n, 0, 0, 0, 0}) do
    n * 8
  end

  def price({n, j, 0, 0, 0}) do
    2 * 8 * 0.95 + price({n - 1, j - 1, 0, 0, 0})
  end

  def price({n, j, k, 0, 0}) do
    3 * 8 * 0.90 + price({n-1, j-1, k-1, 0, 0})
  end

  def price({n, j, k, l, 0}) do
    4 * 8 * 0.85 + price({n-1, j-1, k-1, l-1, 0})
  end

  def price({n, j, k, l, m}) do
    5 * 8 * 0.80 + price({n-1, j-1, k-1, l-1, m-1})
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
    assert Harry.price({5, 4, 3, 2, 1}) == (
      (5 * 8 * 80) 
      + (4 * 8 * 85) 
      + (3 * 8 * 90) 
      + (2 * 8 * 95) 
      + 800) /100
  end

end
