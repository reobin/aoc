defmodule AoC2022.Day14 do
  @moduledoc """
  https://adventofcode.com/2022/day/14
  """

  alias AoC.Grid
  alias AoC.Point

  @sand {500, 0}

  def part_1(input), do: input |> parse() |> simulate() |> count_sand()
  def part_2(input), do: input |> parse() |> add_floor() |> simulate() |> count_sand()

  defp count_sand(grid), do: grid |> Grid.values() |> Enum.count(&(&1 == "o"))

  defp simulate(grid) do
    point = drop_sand(grid, @sand)
    new = Grid.set(grid, point, "o")

    cond do
      is_nil(point) -> grid
      new == grid -> grid
      true -> simulate(new)
    end
  end

  defp drop_sand(grid, {x, y}) do
    void =
      [{x, y + 1}, {x - 1, y + 1}, {x + 1, y + 1}]
      |> Enum.find(fn p -> grid |> Grid.get(p) |> is_nil() end)

    cond do
      y > Grid.max_y(grid) -> nil
      not is_nil(void) -> drop_sand(grid, void)
      true -> {x, y}
    end
  end

  defp parse(input), do: input |> String.split("\n") |> Enum.map(&parse_line/1) |> to_grid()
  defp parse_line(line), do: line |> String.split(" -> ") |> Enum.map(&parse_point/1) |> fill()
  defp parse_point(c), do: c |> String.split(",") |> Enum.map(&String.to_integer/1) |> to_tuple()
  defp to_tuple([x, y]), do: {x, y}

  defp fill(line, path \\ [])
  defp fill([], path), do: path
  defp fill([a], path), do: path ++ [a]

  defp fill([a, b | points], path) do
    between = [a | Point.between(a, b)]
    fill([b | points], path ++ between)
  end

  defp to_grid(lines) do
    lines
    |> Enum.reduce(%{}, fn path, map ->
      Enum.reduce(path, map, fn {x, y}, map -> Grid.set(map, {x, y}, "#") end)
    end)
  end

  defp add_floor(grid) do
    max_y = Grid.max_y(grid)
    0..1000 |> Enum.reduce(grid, fn x, grid -> Grid.set(grid, {x, max_y + 2}, "#") end)
  end
end
