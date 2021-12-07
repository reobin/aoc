defmodule AoC.Day02 do
  @moduledoc """
  https://adventofcode.com/2021/day/2
  """

  def part_1(input) do
    {x, y} =
      input
      |> get_instructions()
      |> Enum.reduce({0, 0}, &go/2)

    x * y
  end

  def part_2(input) do
    {x, y, _aim} =
      input
      |> get_instructions()
      |> Enum.reduce({0, 0, 0}, &go/2)

    x * y
  end

  defp go({"forward", distance}, {x, y}), do: {x + distance, y}
  defp go({"up", distance}, {x, y}), do: {x, y - distance}
  defp go({"down", distance}, {x, y}), do: {x, y + distance}

  defp go({"forward", distance}, {x, y, aim}), do: {x + distance, y + aim * distance, aim}
  defp go({"up", distance}, {x, y, aim}), do: {x, y, aim - distance}
  defp go({"down", distance}, {x, y, aim}), do: {x, y, aim + distance}

  defp get_instructions(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      [direction, distance] = String.split(line, " ")
      {direction, String.to_integer(distance)}
    end)
  end
end
