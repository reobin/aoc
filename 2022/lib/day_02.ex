defmodule AoC.Day02 do
  @moduledoc """
  https://adventofcode.com/2022/day/2
  """

  @rock "A"
  @paper "B"
  @scissors "C"

  @score_rock 1
  @score_paper 2
  @score_scissors 3

  @score_win 6
  @score_draw 3
  @score_lose 0

  def part_1(input), do: input |> parse() |> Enum.map(&score_1/1) |> Enum.sum()

  defp score_1([@rock, "X"]), do: @score_draw + @score_rock
  defp score_1([@rock, "Y"]), do: @score_win + @score_paper
  defp score_1([@rock, "Z"]), do: @score_lose + @score_scissors
  defp score_1([@paper, "X"]), do: @score_lose + @score_rock
  defp score_1([@paper, "Y"]), do: @score_draw + @score_paper
  defp score_1([@paper, "Z"]), do: @score_win + @score_scissors
  defp score_1([@scissors, "X"]), do: @score_win + @score_rock
  defp score_1([@scissors, "Y"]), do: @score_lose + @score_paper
  defp score_1([@scissors, "Z"]), do: @score_draw + @score_scissors

  def part_2(input), do: input |> parse() |> Enum.map(&score_2/1) |> Enum.sum()

  defp score_2([@rock, "X"]), do: @score_lose + @score_scissors
  defp score_2([@rock, "Y"]), do: @score_draw + @score_rock
  defp score_2([@rock, "Z"]), do: @score_win + @score_paper
  defp score_2([@paper, "X"]), do: @score_lose + @score_rock
  defp score_2([@paper, "Y"]), do: @score_draw + @score_paper
  defp score_2([@paper, "Z"]), do: @score_win + @score_scissors
  defp score_2([@scissors, "X"]), do: @score_lose + @score_paper
  defp score_2([@scissors, "Y"]), do: @score_draw + @score_scissors
  defp score_2([@scissors, "Z"]), do: @score_win + @score_rock

  defp parse(input), do: input |> String.split("\n") |> Enum.map(&String.split(&1, " "))
end
