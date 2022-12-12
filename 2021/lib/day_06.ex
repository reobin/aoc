defmodule AoC2021.Day06 do
  @moduledoc """
  https://adventofcode.com/2021/day/6
  """

  alias AoC.String

  def part_1(input, day_count \\ 80), do: input |> get_state() |> get_fish_count(day_count)
  def part_2(input, day_count \\ 256), do: input |> get_state() |> get_fish_count(day_count)

  defp get_fish_count(state, day_count),
    do: 1..day_count |> Enum.reduce(state, &update/2) |> Enum.sum()

  defp update(_day, [zero, one, two, three, four, five, six, seven, eight]),
    do: [one, two, three, four, five, six, zero + seven, eight, zero]

  defp get_state(input), do: 0..8 |> Enum.map(&String.count(input, &1))
end
