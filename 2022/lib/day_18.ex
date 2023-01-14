defmodule AoC2022.Day18 do
  @moduledoc """
  https://adventofcode.com/2022/day/18
  """

  alias AoC.Point
  alias AoC.Grid

  def part_1(input) do
    cubes = parse(input)
    cubes |> Enum.map(&sides_exposed(&1, cubes)) |> Enum.sum()
  end

  def part_2(input) do
    cubes = input |> parse()
    map = cubes |> Map.new(&{&1, true}) |> fill()

    initial = {Grid.min_x(map), Grid.min_y(map), Grid.min_z(map)}

    cubes
    |> Enum.flat_map(&Point.neighbors/1)
    |> Enum.filter(&exposed?(map, initial, &1))
    |> Enum.count()
  end

  defp exposed?(map, from, to) do
    can_move? = fn map, _, to -> not Grid.get(map, to) end
    Grid.shortest_path(map, from, to, can_move?: can_move?) != :infinity
  end

  defp fill(map) do
    Enum.reduce((Grid.min_x(map) - 1)..(Grid.max_x(map) + 1), map, fn x, acc ->
      Enum.reduce((Grid.min_y(map) - 1)..(Grid.max_y(map) + 1), acc, fn y, acc ->
        Enum.reduce((Grid.min_z(map) - 1)..(Grid.max_z(map) + 1), acc, fn z, acc ->
          if Map.has_key?(acc, {x, y, z}) do
            acc
          else
            Map.put(acc, {x, y, z}, false)
          end
        end)
      end)
    end)
  end

  defp sides_exposed(point, cubes) do
    point
    |> Point.neighbors()
    |> Enum.filter(fn p -> not Enum.any?(cubes, &(&1 == p)) end)
    |> Enum.count()
  end

  defp parse(input), do: input |> String.split("\n") |> Enum.map(&coord/1)
  defp coord(l), do: l |> String.split(",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
end
