defmodule AoC2021.Day15 do
  @moduledoc """
  https://adventofcode.com/2021/day/15
  """

  alias AoC.Grid

  def part_1(input), do: input |> Grid.from_string(integer?: true) |> shortest_path()

  def part_2(input),
    do: input |> Grid.from_string(integer?: true) |> Grid.expand(5, 5, &inc/2) |> shortest_path()

  defp shortest_path(map) do
    {width, height} = Grid.size(map)
    target = {width - 1, height - 1}

    Grid.shortest_path(map, {0, 0}, target, cost: &Map.get(&1, &2))
  end

  defp inc(cell, {dx, dy}), do: get_risk_level(cell + dx + dy)

  defp get_risk_level(value) when value > 9, do: value - 9
  defp get_risk_level(value), do: value
end
