defmodule AoC.Day01 do
  def part_1(input),
    do:
      input
      |> parse_modules_mass()
      |> Enum.map(&compute_fuel/1)
      |> Enum.sum()

  def part_2(input),
    do:
      input
      |> parse_modules_mass()
      |> Enum.map(fn mass -> mass |> compute_fuel() |> add_fuel() end)
      |> Enum.sum()

  defp add_fuel(mass), do: add_fuel(mass, mass)

  defp add_fuel(mass, sum) do
    case compute_fuel(mass) do
      mass when mass < 1 -> sum
      mass -> add_fuel(mass, sum + mass)
    end
  end

  defp compute_fuel(mass), do: Integer.floor_div(mass, 3) - 2

  defp parse_modules_mass(input),
    do:
      input
      |> String.split("\n")
      |> Enum.filter(fn line -> String.length(line) > 0 end)
      |> Enum.map(&String.to_integer/1)
end
