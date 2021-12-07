defmodule AoC.Day07 do
  @moduledoc """
  https://adventofcode.com/2021/day/7
  """

  def part_1(input), do: input |> get_positions() |> get_optimal_alignment(:naive_algorithm)
  def part_2(input), do: input |> get_positions() |> get_optimal_alignment(:crab_algorithm)

  defp get_optimal_alignment(positions, algorithm) do
    positions
    |> Enum.min_max()
    |> then(fn {min, max} -> min..max end)
    |> Enum.map(&get_total_fuel_consumption(&1, positions, algorithm))
    |> Enum.min()
  end

  defp get_total_fuel_consumption(target, positions, algorithm),
    do: positions |> Enum.map(&get_fuel_consumption(&1, target, algorithm)) |> Enum.sum()

  defp get_fuel_consumption(position, target, :naive_algorithm), do: abs(target - position)

  defp get_fuel_consumption(position, target, :crab_algorithm) do
    distance = abs(target - position)
    div(distance * (distance + 1), 2)
  end

  defp get_positions(input),
    do: input |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
end
