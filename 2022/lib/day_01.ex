defmodule AoC2022.Day01 do
  @moduledoc """
  https://adventofcode.com/2022/day/1
  """

  def part_1(input), do: input |> get_elves() |> Enum.max()

  def part_2(input),
    do: input |> get_elves() |> Enum.sort(:desc) |> Enum.slice(0, 3) |> Enum.sum()

  defp get_elves(input), do: input |> String.split("\n\n") |> Enum.map(&count_calories/1)

  defp count_calories(elf),
    do: elf |> String.split("\n") |> Enum.map(&String.to_integer/1) |> Enum.sum()
end
