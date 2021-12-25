defmodule AoC.Day25 do
  @moduledoc """
  https://adventofcode.com/2021/day/25
  """

  alias AoC.Modules.Grid

  def part_1(input), do: input |> Grid.from_string() |> steps_to_stable()

  defp steps_to_stable(map, step \\ 1) do
    initial = map

    map = map |> move_all(">") |> move_all("v")

    if map == initial, do: step, else: steps_to_stable(map, step + 1)
  end

  defp move_all(map, cucumber) do
    map
    |> Grid.get_points()
    |> Enum.filter(&(Grid.get(map, &1) == cucumber))
    |> Enum.reduce(map, &move(&2, &1, cucumber, map))
  end

  defp move(map, from, cucumber, ref), do: move(map, from, to(map, from, cucumber), cucumber, ref)

  defp move(map, from, to, c, ref) do
    if Grid.get(ref, to) == ".", do: map |> Grid.set(from, ".") |> Grid.set(to, c), else: map
  end

  defp to(m, {x, y}, ">"), do: to(map, {x + 1, y}, {0, y})
  defp to(m, {x, y}, "v"), do: to(map, {x, y + 1}, {x, 0})
  defp to(map, target, backup), do: if(is_nil(Grid.get(map, target)), do: backup, else: target)

  def part_2(_input), do: ""
end
