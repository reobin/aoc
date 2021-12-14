defmodule AoC.Day14 do
  @moduledoc """
  https://adventofcode.com/2021/day/14
  """

  def part_1(input), do: input |> parse() |> get_output(10)
  def part_2(input), do: input |> parse() |> get_output(40)

  defp get_output(state, step_count) do
    1..step_count
    |> Enum.reduce(state, &compute_characters/2)
    |> elem(1)
    |> Map.values()
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  defp compute_characters(_step, {pairs, characters, rules}) do
    rules
    |> Map.keys()
    |> Enum.reduce(
      {pairs, characters, rules},
      fn [first, last], {new_pairs, characters, rules} ->
        character = Map.get(rules, [first, last])

        count = Map.get(pairs, [first, last], 0)

        new_pairs =
          new_pairs
          |> Map.update([first, last], -count, &(&1 - count))
          |> Map.update([first, character], count, &(&1 + count))
          |> Map.update([character, last], count, &(&1 + count))

        characters = Map.update(characters, character, count, &(&1 + count))

        {new_pairs, characters, rules}
      end
    )
  end

  defp parse(input) do
    [template, rules] = input |> String.split("\n\n")

    pairs =
      template |> String.graphemes() |> Enum.chunk_every(2, 1, :discard) |> Enum.frequencies()

    characters = template |> String.graphemes() |> Enum.frequencies()

    rules =
      rules
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, fn rule, rules ->
        [pair, element] = String.split(rule, " -> ")
        Map.put(rules, String.split(pair, "", trim: true), element)
      end)

    {pairs, characters, rules}
  end
end
