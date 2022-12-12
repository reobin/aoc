defmodule AoC2019.Day01 do
  @moduledoc """
  https://adventofcode.com/2019/day/1
  """

  def part_1(input),
    do: input |> get_mass() |> Enum.map(&compute_required_fuel/1) |> Enum.sum()

  def part_2(input) do
    input
    |> get_mass()
    |> Enum.map(&compute_required_fuel(&1, :consider_fuel_mass))
    |> Enum.sum()
  end

  defp compute_required_fuel(mass, option \\ nil)
  defp compute_required_fuel(mass, _option) when mass <= 0, do: 0

  defp compute_required_fuel(mass, :consider_fuel_mass) do
    fuel = compute_required_fuel(mass)
    fuel + compute_required_fuel(fuel, :consider_fuel_mass)
  end

  defp compute_required_fuel(mass, _option),
    do: mass |> Integer.floor_div(3) |> then(&(&1 - 2)) |> then(&if(&1 < 0, do: 0, else: &1))

  defp get_mass(input),
    do: input |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)
end
