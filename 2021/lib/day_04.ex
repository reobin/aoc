defmodule AoC.Day04 do
  @moduledoc """
  https://adventofcode.com/2021/day/4
  """

  alias AoC.Modules.Grid

  @mark "X"

  def part_1(input) do
    {numbers, boards} = get_game(input)

    {_boards, winning_board, last_drawn_number} =
      numbers
      |> Enum.reduce_while(
        {boards, nil, nil},
        fn number, {boards, _winning_board, _last_drawn_number} ->
          boards = Enum.map(boards, &Grid.replace(&1, number, @mark))

          winning_board = Enum.find(boards, &wins?/1)

          action = if is_nil(winning_board), do: :cont, else: :halt
          {action, {boards, winning_board, number}}
        end
      )

    compute_score(winning_board, last_drawn_number)
  end

  def part_2(input) do
    {numbers, boards} = get_game(input)

    {[losing_board], last_drawn_number} =
      numbers
      |> Enum.reduce_while(
        {boards, nil},
        fn number, {boards, _last_drawn_number} ->
          boards = Enum.map(boards, &Grid.replace(&1, number, @mark))

          remaining_boards = Enum.filter(boards, &continues?/1)

          if Enum.count(remaining_boards) == 0 do
            {:halt, {boards, number}}
          else
            {:cont, {remaining_boards, number}}
          end
        end
      )

    compute_score(losing_board, last_drawn_number)
  end

  defp compute_score(board, last_drawn_number) do
    sum = board |> get_remaining_numbers() |> Enum.sum()
    sum * String.to_integer(last_drawn_number)
  end

  defp get_remaining_numbers(board) do
    board
    |> Grid.get_values()
    |> Enum.filter(fn value -> value != @mark end)
    |> Enum.map(&String.to_integer/1)
  end

  defp continues?(board), do: not wins?(board)

  defp wins?(board), do: wins?(board, :rows) or wins?(board, :columns)

  defp wins?(board, :rows) do
    board
    |> Grid.get_rows()
    |> Enum.any?(fn row -> row |> Enum.all?(fn cell -> cell == @mark end) end)
  end

  defp wins?(board, :columns) do
    board
    |> Grid.get_columns()
    |> Enum.any?(fn column -> column |> Enum.all?(fn cell -> cell == @mark end) end)
  end

  defp get_game(input) do
    [numbers | boards] = input |> String.split("\n\n", trim: true)

    {
      numbers |> String.split(",", trim: true),
      boards |> Enum.map(&Grid.from_string/1)
    }
  end
end
