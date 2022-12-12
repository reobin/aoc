defmodule AoC2022.Day04 do
  @moduledoc """
  https://adventofcode.com/2022/day/4
  """

  def part_1(input) do
    input
    |> parse()
    |> Enum.map(fn ranges -> Enum.map(ranges, &MapSet.new/1) end)
    |> Enum.filter(fn [r_1, r_2] -> MapSet.subset?(r_1, r_2) or MapSet.subset?(r_2, r_1) end)
    |> Enum.count()
  end

  def part_2(input) do
    input
    |> parse()
    |> Enum.filter(fn [r_1, r_2] -> not Range.disjoint?(r_1, r_2) end)
    |> Enum.count()
  end

  defp parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn line -> line |> Enum.map(&parse_range/1) end)
  end

  defp parse_range(r),
    do: r |> String.split("-") |> Enum.map(&String.to_integer/1) |> then(fn [f, t] -> f..t end)
end
