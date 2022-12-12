defmodule AoC2022.Day03 do
  @moduledoc """
  https://adventofcode.com/2022/day/3
  """

  alias AoC.List

  @score String.codepoints("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

  def part_1(input), do: input |> parse() |> Enum.map(&List.split(&1, 2)) |> compute_score()
  def part_2(input), do: input |> parse() |> Enum.chunk_every(3) |> compute_score()

  defp parse(input), do: input |> String.split("\n") |> Enum.map(&String.codepoints/1)

  defp compute_score(sacks),
    do: sacks |> Enum.flat_map(&List.intersection/1) |> Enum.map(&char_to_score/1) |> Enum.sum()

  defp char_to_score(c), do: Enum.find_index(@score, &(&1 == c)) + 1
end
