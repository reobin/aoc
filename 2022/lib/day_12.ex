defmodule AoC2022.Day12 do
  @moduledoc """
  https://adventofcode.com/2022/day/12
  """

  alias AoC.Grid

  def part_1(input) do
    map = Grid.from_string(input)
    from = map |> Grid.points() |> Enum.find(&(Grid.get(map, &1) == "S"))
    to = map |> Grid.points() |> Enum.find(&(Grid.get(map, &1) == "E"))
    Grid.shortest_path(map, from, to, can_move?: &can_move?/3)
  end

  def part_2(input) do
    grid = Grid.from_string(input)
    to = grid |> Grid.points() |> Enum.find(&(Grid.get(grid, &1) == "E"))

    grid
    |> Grid.points()
    |> Enum.filter(&(Grid.get(grid, &1) in ["S", "a"]))
    |> Enum.map(fn from -> Grid.shortest_path(grid, from, to, can_move?: &can_move?/3) end)
    |> Enum.min()
  end

  defp can_move?(map, from, to) do
    elevation_from = map |> Grid.get(from) |> elevation()
    elevation_to = map |> Grid.get(to) |> elevation()
    elevation_from >= elevation_to or elevation_to - elevation_from <= 1
  end

  @alphabet String.codepoints("abcdefghijklmnopqrstuvwxyz")

  defp elevation("S"), do: elevation("a")
  defp elevation("E"), do: elevation("z")
  defp elevation(value), do: Enum.find_index(@alphabet, &(&1 == value))
end
