defmodule AoC.Day09 do
  @moduledoc """
  https://adventofcode.com/2021/day/9
  """

  alias AoC.Modules.Grid
  alias AoC.Modules.Point

  @highest_level 9

  def part_1(input) do
    grid = input |> Grid.from_string(column_divider: "", is_integer?: true)
    grid |> get_low_points() |> Enum.map(&compute_risk_level(&1, grid)) |> Enum.sum()
  end

  def part_2(input) do
    grid = input |> Grid.from_string(column_divider: "", is_integer?: true)

    grid
    |> get_low_points()
    |> Enum.with_index()
    |> Enum.reduce(grid, &fill_basin/2)
    |> get_basin_sizes()
    |> compute_basins_score()
  end

  defp get_low_points(grid) do
    grid
    |> Grid.get_points()
    |> Enum.filter(&is_low_point?(&1, grid))
  end

  defp is_low_point?(point, grid) do
    point
    |> Point.get_neighbors()
    |> Enum.all?(&(Grid.get(grid, point) < Grid.get(grid, &1, @highest_level)))
  end

  defp compute_risk_level(point, grid), do: Grid.get(grid, point) + 1

  defp fill_basin({point, basin_index}, grid) do
    case Grid.get(grid, point, @highest_level) do
      @highest_level ->
        grid

      _ ->
        grid = Grid.set(grid, point, "b#{basin_index}")

        point
        |> Point.get_neighbors()
        |> Enum.filter(&is_integer(Grid.get(grid, &1)))
        |> Enum.reduce(grid, fn adjacent_point, grid ->
          fill_basin({adjacent_point, basin_index}, grid)
        end)
    end
  end

  defp get_basin_sizes(grid) do
    grid
    |> Grid.get_values()
    |> Enum.filter(&(&1 != @highest_level))
    |> Enum.group_by(& &1)
    |> Map.values()
    |> Enum.map(&Enum.count/1)
  end

  defp compute_basins_score(basins) do
    basins
    |> Enum.sort()
    |> Enum.take(-3)
    |> Enum.product()
  end
end
