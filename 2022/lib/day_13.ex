defmodule AoC2022.Day13 do
  @moduledoc """
  https://adventofcode.com/2022/day/13
  """

  def part_1(input) do
    input
    |> parse()
    |> Enum.with_index(1)
    |> Enum.filter(fn {[a, b], _i} -> compare(a, b) end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  @divider_packets [[[2]], [[6]]]

  def part_2(input) do
    input
    |> parse(:flat)
    |> Enum.concat(@divider_packets)
    |> Enum.sort(&compare/2)
    |> Enum.with_index(1)
    |> Enum.filter(fn {packet, _i} -> packet in @divider_packets end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.product()
  end

  defp compare([head_a | a], [head_b | b]),
    do: head_a |> compare(head_b) |> then(fn r -> if(is_nil(r), do: compare(a, b), else: r) end)

  defp compare(nil, _b), do: true
  defp compare(_a, nil), do: false
  defp compare(a, b) when is_integer(a) and is_list(b), do: compare([a], b)
  defp compare(a, b) when is_list(a) and is_integer(b), do: compare(a, [b])
  defp compare(a, a), do: nil
  defp compare(a, b), do: a < b

  defp parse(input, :flat), do: input |> String.split("\n\n") |> Enum.flat_map(&parse_group/1)
  defp parse(input), do: input |> String.split("\n\n") |> Enum.map(&parse_group/1)
  defp parse_group(input), do: input |> String.split("\n") |> Enum.map(&eval/1)
  defp eval(input), do: input |> Code.eval_string() |> elem(0)
end
