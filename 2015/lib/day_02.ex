defmodule AoC.Day02 do
  @moduledoc """
  https://adventofcode.com/2015/day/2
  """

  def part_1(input), do: input |> parse() |> Enum.map(&paper_needed/1) |> Enum.sum()
  def part_2(input), do: input |> parse() |> Enum.map(&ribbon_needed/1) |> Enum.sum()

  defp paper_needed([w, h, l]),
    do: 2 * l * w + 2 * w * h + 2 * h * l + Enum.min([l * w, w * h, h * l])

  defp parse(input), do: input |> String.split("\n") |> Enum.map(&parse_line/1)

  defp parse_line(line), do: line |> String.split("x") |> Enum.map(&String.to_integer/1)

  defp ribbon_needed(dimensions),
    do: dimensions |> Enum.sort() |> then(fn [a, b, c] -> 2 * a + 2 * b + a * b * c end)
end
