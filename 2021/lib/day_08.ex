defmodule AoC.Day08 do
  @moduledoc """
  https://adventofcode.com/2021/day/8
  """

  def part_1(input) do
    input
    |> get_entries()
    |> Enum.flat_map(fn {_patterns, output} -> output end)
    |> Enum.count(&(String.length(&1) in [2, 3, 4, 7]))
  end

  def part_2(input), do: input |> get_entries() |> Enum.map(&compute_output_value/1) |> Enum.sum()

  defp compute_output_value({signal_patterns, output}) do
    digit_pattern =
      signal_patterns |> Enum.map(&String.split(&1, "", trim: true)) |> get_digit_pattern()

    output
    |> Enum.map(&Map.get(digit_pattern, &1, ""))
    |> Enum.join("")
    |> then(&String.to_integer/1)
  end

  defp get_digit_pattern(signal_patterns) do
    %{
      2 => [one],
      3 => [seven],
      4 => [four],
      5 => two_three_five,
      6 => zero_six_nine,
      7 => [eight]
    } = signal_patterns |> Enum.group_by(&Enum.count/1)

    nine = zero_six_nine |> Enum.find(&(count_differences(four, &1) == 0))
    zero = zero_six_nine |> Enum.find(fn v -> v != nine and count_differences(seven, v) == 0 end)
    [six] = zero_six_nine -- [nine, zero]

    three = two_three_five |> Enum.find(&(count_differences(seven, &1) == 0))
    five = two_three_five |> Enum.find(&(count_differences(&1, six) == 0))
    [two] = two_three_five -- [three, five]

    [zero, one, two, three, four, five, six, seven, eight, nine]
    |> Enum.map(&Enum.join/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {value, index}, pattern ->
      Map.put(pattern, value, Integer.to_string(index))
    end)
  end

  defp count_differences(value_a, value_b), do: Enum.count(value_a -- value_b)

  defp get_entries(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      [signal_patterns, output] = String.split(line, " | ")

      signal_patterns = signal_patterns |> String.split() |> sort()
      output = output |> String.split() |> sort()

      {signal_patterns, output}
    end)
  end

  defp sort(patterns) do
    patterns
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(&Enum.sort/1)
    |> Enum.map(&Enum.join/1)
  end
end
