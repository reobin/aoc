defmodule AoC.Day05 do
  @moduledoc """
  https://adventofcode.com/2021/day/5
  """

  alias AoC.Modules.Point

  def part_1(input) do
    input |> get_lines_of_vents() |> Enum.filter(&is_straight?/1) |> compute_intersections()
  end

  def part_2(input) do
    input |> get_lines_of_vents() |> compute_intersections()
  end

  defp compute_intersections(lines_of_vents) do
    lines_of_vents
    |> Enum.flat_map(fn {from, to} -> Point.get_line(from, to) end)
    |> Enum.frequencies()
    |> Enum.count(fn {_point, frequency} -> frequency >= 2 end)
  end

  defp is_straight?({{x1, y1}, {x2, y2}}) when x1 == x2 or y1 == y2, do: true
  defp is_straight?(_line), do: false

  defp get_lines_of_vents(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [from, to] = String.split(line, " -> ")

      [x1, y1] = String.split(from, ",") |> Enum.map(&String.to_integer/1)
      [x2, y2] = String.split(to, ",") |> Enum.map(&String.to_integer/1)

      {{x1, y1}, {x2, y2}}
    end)
  end
end
