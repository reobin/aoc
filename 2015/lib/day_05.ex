defmodule AoC.Day05 do
  @moduledoc """
  https://adventofcode.com/2015/day/5
  """

  alias AoC.Modules.List

  @vowels ~w(a e i o u)

  def part_1(input),
    do: input |> String.split("\n") |> Enum.filter(&nice?(&1, :part_1)) |> Enum.count()

  def part_2(input),
    do: input |> String.split("\n") |> Enum.filter(&nice?(&1, :part_2)) |> Enum.count()

  defp nice?(w, :part_1), do: has_three_vowels?(w) and has_double?(w) and not has_forbidden?(w)
  defp nice?(w, :part_2), do: has_double_pair?(w) and has_repeating_letter?(w)

  defp has_three_vowels?(word),
    do: word |> String.codepoints() |> Enum.filter(&vowel?/1) |> Enum.count() >= 3

  defp vowel?(char), do: char in @vowels

  defp has_double?(w),
    do: w |> String.codepoints() |> Enum.chunk_every(2, 1, :discard) |> Enum.any?(&double?/1)

  defp double?([a, a]), do: true
  defp double?(_), do: false

  defp has_forbidden?(w),
    do: w |> String.graphemes() |> Enum.chunk_every(2, 1, :discard) |> Enum.any?(&forbidden?/1)

  defp forbidden?(["a", "b"]), do: true
  defp forbidden?(["c", "d"]), do: true
  defp forbidden?(["p", "q"]), do: true
  defp forbidden?(["x", "y"]), do: true
  defp forbidden?(_), do: false

  defp has_double_pair?(word) do
    word
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.chunk_every(2, 1, :discard)
    |> List.pairs()
    |> Enum.any?(&double_pair?/1)
  end

  defp double_pair?([[{a, ia}, {b, ib}], [{a, ja}, {b, jb}]]), do: List.unique?([ia, ja, ib, jb])
  defp double_pair?(_), do: false

  defp has_repeating_letter?(word) do
    word
    |> String.codepoints()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.any?(&repeating_letter?/1)
  end

  defp repeating_letter?([a, _b, a]), do: true
  defp repeating_letter?(_), do: false
end
