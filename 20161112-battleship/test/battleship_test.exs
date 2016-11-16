# Batalha Naval

# Você está resolvendo este problema. 
# Este problema foi utilizado em 133 Dojo(s).
# Cada jogador deve dispor de uma área de 10x10 onde ele vai posicionar 5 navios de tamanhos diferentes: um porta-aviões (comprimento 5), um encouraçado (comprimento 4), um submarino e um destroyer (ambom de comprimento 3), e barco de patrulha (comprimento 2). Um jogador nunca deve saber a posição dos navios do oponente. Os navios de um mesmo jogador não podem se cruzar e devem estar dentro das fronteiras da sua área disponível.
# Depois que todas as peças estão posicionadas, os jogadores se alternam em turnos para lançar bombas sobre o outro oponente especificando qual posição ele deseja atacar. Se algum dos navios do jogador que está sendo atacado estiver na posição atacada, considera-se que o navio foi atingido. O ataque falha se o atacante lançar uma bomba em um local onde não existe nenhum navio do oponente.
# Caso todos as posições de um navio for atingida, o jogador atacado deve informar o oponente qual dos seus navios afundou. O jogo continua até que um jogador afunde todos os navios de seu oponente; este jogador é então considerado vencedor.
# Você deve desenvolver um programa que jogue uma partida de batalha naval entre dois oponentes. Você precisa:
# Definir uma maneira de indicar o estado inicial dos navios dos jogadores;
# Exibir todos os movimentos dos jogadores, informando se os ataques foram bem sucedidos ou não;
# Informar quando um navio é atingido e quando ele é afundado;
# Exibir ao final do jogo um mapa final do posicionamento final dos navios dos jogadores.

# Adaptado de: http://www.facebook.com/careers/puzzles.php?puzzle_id=14

# PPPPP 
# EEEE
# SSS
# DDD
# BB


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
    |> String.strip

  def valid? board do
    clean_board = board
    |> cleanup_horizontal
    |> transpose
    |> cleanup_horizontal

    clean_board == @initial_state
  end

  def generate do
    x = :rand.uniform(10) - 1
    y = :rand.uniform(10) - 1
    orientation = :rand.uniform(2) -1

    @initial_state
  end

  defp cleanup_horizontal(board) do
    board
    |> String.replace("PPPPP", ".....")
    |> String.replace("EEEE", "....")
    |> String.replace("DDD", "...")
    |> String.replace("SSS", "...")
    |> String.replace("BB", "..")
  end

  defp transpose board do
    board
    |> String.split
    |> Enum.map(&String.graphemes/1)
    |> List.zip
    |> Enum.map(fn line ->
      Tuple.to_list(line) |> Enum.join
    end)
    |> Enum.join("\n")
  end
end


defmodule BattleshipTest do
  use ExUnit.Case
  doctest Battleship

  test "valid board" do
    actual = Battleship.Board.valid? ~s"""
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
    assert actual == true
  end

  test "valid board with all pieces horizontally" do
    actual = Battleship.Board.valid? ~s"""
    ..........
    ..PPPPP...
    ..........
    ..EEEE....
    .....BB...
    ..........
    ...SSS....
    ..........
    ....DDD...
    ..........
    """
    assert actual == true
  end

  test "valid board with all pieces vertically" do
    actual = Battleship.Board.valid? ~s"""
    B.........
    B.S.......
    ..S.E.....
    ..S.E.....
    ....E.....
    ..D.E..P..
    ..D....P..
    ..D....P..
    .......P..
    .......P..
    """
    assert actual == true
  end

  # test "can generate valid board" do
  #   board = Battleship.Board.generate
  #   assert_contains(board, "B")
  #   assert Battleship.Board.valid?(board) == true
  # end

  defp assert_contains string, contents do
    assert String.contains?(string, contents)
  end

end