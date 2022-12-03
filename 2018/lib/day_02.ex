defmodule AoC.Day02 do
  @moduledoc """
  https://adventofcode.com/2018/day/2
  """

  alias AoC.Modules.List

  def part_1(input) do
    input
    |> String.split("\n")
    |> Enum.map(&count_twos_and_threes/1)
    |> Enum.reduce({0, 0}, fn {twos, threes}, {twos_acc, threes_acc} ->
      {twos_acc + min(1, twos), threes_acc + min(1, threes)}
    end)
    |> then(&(elem(&1, 0) * elem(&1, 1)))
  end

  defp count_twos_and_threes(string) do
    string
    |> String.codepoints()
    |> Enum.group_by(& &1)
    |> Enum.map(&length(elem(&1, 1)))
    |> Enum.filter(&(&1 in [2, 3]))
    |> then(fn counts ->
      {Enum.count(counts, &(&1 == 2)), Enum.count(counts, &(&1 == 3))}
    end)
  end

  def part_2(input) do
    input
    |> String.split("\n")
    |> List.pairs()
    |> Enum.find(&(count_differences(&1) == 1))
    |> then(&substract_diff/1)
  end

  defp count_differences([a, b]) do
    a
    |> String.codepoints()
    |> Enum.zip(b |> String.codepoints())
    |> Enum.filter(fn {a, b} -> a != b end)
    |> length()
  end

  defp substract_diff([a, b]) do
    a
    |> String.codepoints()
    |> Enum.zip(b |> String.codepoints())
    |> Enum.filter(fn {a, b} -> a == b end)
    |> Enum.map(fn {a, _} -> a end)
    |> Enum.join()
  end
end
