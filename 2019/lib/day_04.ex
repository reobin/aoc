defmodule AoC.Day04 do
  @moduledoc """
  https://adventofcode.com/2019/day/4
  """

  def part_1(input), do: input |> get_range() |> Enum.count(&is_valid?(&1, :loose))
  def part_2(input), do: input |> get_range() |> Enum.count(&is_valid?(&1, :strict))

  defp get_range(input) do
    input
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> then(fn [min, max] -> min..max end)
  end

  defp is_valid?(password, option),
    do: password |> Integer.digits() |> then(&(increments?(&1) and has_double?(&1, option)))

  defp increments?([]), do: true
  defp increments?([d1 | [d2 | _]]) when d1 > d2, do: false
  defp increments?([_ | digits]), do: increments?(digits)

  defp has_double?([], :strict), do: false
  defp has_double?([_d], :strict), do: false
  defp has_double?([d, d, d, d, d | _digits], :strict), do: false
  defp has_double?([d, d, d, d | digits], :strict), do: has_double?(digits, :strict)
  defp has_double?([d, d, d | digits], :strict), do: has_double?(digits, :strict)
  defp has_double?([d, d | _digits], :strict), do: true
  defp has_double?([_d | digits], :strict), do: has_double?(digits, :strict)

  defp has_double?([], :loose), do: false
  defp has_double?([d | [d | _]], :loose), do: true
  defp has_double?([_ | digits], :loose), do: has_double?(digits, :loose)
end
