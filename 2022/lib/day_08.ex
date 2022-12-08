defmodule AoC.Day08 do
  @moduledoc """
  https://adventofcode.com/2022/day/8
  """

  alias AoC.Modules.Grid
  alias AoC.Modules.Point

  def part_1(input) do
    grid = Grid.from_string(input, column_divider: "", integer?: true)
    grid |> Grid.points() |> Enum.filter(&visible?(grid, &1)) |> Enum.count()
  end

  def part_2(input) do
    grid = Grid.from_string(input, column_divider: "", integer?: true)
    grid |> Grid.points() |> Enum.map(&scenic_score(grid, &1)) |> Enum.max()
  end

  defp visible?(grid, point) do
    grid
    |> get_4d_heights(point)
    |> Enum.any?(fn heights ->
      not Enum.any?(heights, fn height -> Grid.get(grid, point) <= height end)
    end)
  end

  defp scenic_score(grid, point) do
    grid
    |> get_4d_heights(point)
    |> Enum.map(fn heights ->
      Enum.reduce_while(heights, 0, fn height, score ->
        if height >= Grid.get(grid, point), do: {:halt, score + 1}, else: {:cont, score + 1}
      end)
    end)
    |> Enum.product()
  end

  defp get_4d_heights(grid, {x, y} = point) do
    {width, height} = Grid.size(grid)

    [{x, 0}, {width - 1, y}, {x, height - 1}, {0, y}]
    |> Enum.map(&(Point.between(point, &1) ++ [&1]))
    |> Enum.map(fn points -> Enum.reject(points, &(&1 == point)) end)
    |> Enum.map(fn points -> Enum.map(points, &Grid.get(grid, &1, 0)) end)
  end
end
