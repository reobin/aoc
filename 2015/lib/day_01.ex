defmodule AoC.Day01 do
  @moduledoc """
  https://adventofcode.com/2015/day/1
  """

  def part_1(input),
    do: input |> String.split("", trim: true) |> Enum.map(&to_integer/1) |> Enum.sum()

  def part_2(input) do
    input
    |> String.split("", trim: true)
    |> Enum.map(&to_integer/1)
    |> Enum.with_index()
    |> Enum.reduce_while(0, &stop_in_basement/2)
  end

  defp stop_in_basement({move, index}, floor) when floor + move < 0, do: {:halt, index + 1}
  defp stop_in_basement({move, _index}, floor), do: {:cont, floor + move}

  defp to_integer("("), do: 1
  defp to_integer(")"), do: -1
  defp to_integer(_), do: 0
end
