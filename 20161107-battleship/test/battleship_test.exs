defmodule Battleship.Board do

  @initial_state ~s"""
    ..........
    ..........
    ..........
    ..........
    ..........
    ..........
    ..........
    ..........
    ..........
    ..........
  """

  defstruct state: @initial_state

  def init do
    %Battleship.Board{}
  end

  def valid?(board) do
    state = %{
      "BB" => "..",
      "DDD" => "...",
      "SSS" => "...",
      "EEEE" => "....",
      "PPPPP" => "....."
    } |> Enum.reduce(board.state, fn ({find, replacement}, state) -> 
      String.replace(state, find, replacement)
    end)
    state == @initial_state
  end
end

defmodule BattleshipTest do
  use ExUnit.Case
  doctest Battleship

  test "valid board initial state" do
    valid = Battleship.Board.init
    |> Battleship.Board.valid?

    assert true == valid
  end

  test "valid non empty board" do
    board = %Battleship.Board{state: ~s"""
      BBDDD.....
      ..........
      .....PPPPP
      ..........
      EEEE......
      ..........
      ..........
      ..........
      .....SSS..
      ..........
    """}
    valid = Battleship.Board.valid?(board)
    assert true == valid 
  end
end
