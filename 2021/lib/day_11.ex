defmodule AoC.Day11 do
  @moduledoc """
  https://adventofcode.com/2021/day/11
  """

  alias AoC.Modules.Grid
  alias AoC.Modules.Point

  def part_1(input), do: input |> Grid.from_string(is_integer?: true) |> run_steps(100) |> elem(1)
  def part_2(input), do: input |> Grid.from_string(is_integer?: true) |> run_steps(1000)

  defp run_steps(grid, step_count), do: 1..step_count |> Enum.reduce_while({grid, 0}, &run_step/2)

  defp run_step(step, {grid, total_flash_count}) do
    grid = grid |> Grid.get_points() |> Enum.reduce(grid, &increment(&1, &2, &2[&1]))

    flash_count = Grid.count(grid, :flash)

    if flash_count == Grid.count(grid) do
      {:halt, step}
    else
      grid = Grid.replace(grid, :flash, 0)
      {:cont, {grid, total_flash_count + flash_count}}
    end
  end

  defp increment(_octopus, grid, :flash), do: grid
  defp increment(_octopus, grid, nil), do: grid

  defp increment(octopus, grid, 9) do
    octopus
    |> Point.get_neighbors(8)
    |> Enum.reduce(Grid.set(grid, octopus, :flash), &increment(&1, &2, &2[&1]))
  end

  defp increment(octopus, grid, energy_level), do: Grid.set(grid, octopus, energy_level + 1)
end
