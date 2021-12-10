defmodule AoC.Day10 do
  @moduledoc """
  https://adventofcode.com/2021/day/10
  """

  @closing_brackets [")", "]", "}", ">"]

  def part_1(input) do
    input
    |> get_lines()
    |> Enum.map(&process/1)
    |> Enum.filter(&(elem(&1, 0) == :corrupted))
    |> Enum.map(&get_score(elem(&1, 1)))
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> get_lines()
    |> Enum.map(&process/1)
    |> Enum.filter(&(elem(&1, 0) == :incomplete))
    |> Enum.map(&compute_total_score(elem(&1, 1)))
    |> Enum.sort()
    |> then(fn scores -> Enum.at(scores, div(length(scores), 2)) end)
  end

  defp process(line), do: process(line, [])
  defp process([], stack), do: {:incomplete, stack}

  defp process([character | line], stack) when character in @closing_brackets do
    [item | stack] = stack
    if matches?(item, character), do: process(line, stack), else: {:corrupted, character}
  end

  defp process([character | line], stack) do
    stack = [character | stack]
    process(line, stack)
  end

  defp matches?("(", ")"), do: true
  defp matches?("[", "]"), do: true
  defp matches?("{", "}"), do: true
  defp matches?("<", ">"), do: true
  defp matches?(_c_1, _c_2), do: false

  defp get_total_score(characters),
    do: characters |> Enum.reduce(0, fn character, score -> score * 5 + get_score(character) end)

  defp get_score(")"), do: 3
  defp get_score("]"), do: 57
  defp get_score("}"), do: 1197
  defp get_score(">"), do: 25137

  defp get_score("("), do: 1
  defp get_score("["), do: 2
  defp get_score("{"), do: 3
  defp get_score("<"), do: 4

  defp get_score(_character), do: 0

  defp get_lines(input),
    do: input |> String.split("\n", trim: true) |> Enum.map(&String.split(&1, "", trim: true))
end
