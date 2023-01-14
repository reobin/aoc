defmodule AoC2022.Day20 do
  @moduledoc """
  https://adventofcode.com/2022/day/20
  """

  alias AoC.List, as: ListHelper

  @decryption_key 811_589_153

  def part_1(input), do: input |> parse() |> mix() |> grove()
  def part_2(input), do: input |> parse() |> multiply(@decryption_key) |> mix(10) |> grove()

  defp parse(input),
    do: input |> String.split("\n") |> Enum.map(&String.to_integer/1) |> Enum.with_index()

  defp multiply(list, factor), do: Enum.map(list, &{elem(&1, 0) * factor, elem(&1, 1)})

  defp mix(list, count), do: Enum.reduce(1..count, list, fn _, list -> mix(list) end)
  defp mix(list), do: Enum.reduce(0..(length(list) - 1), list, &move/2)

  defp move(index, list) do
    {value, _} = element = Enum.find(list, &(elem(&1, 1) == index))
    i = Enum.find_index(list, &(&1 == element))
    next_i = i + value

    list
    |> List.delete_at(i)
    |> then(&List.insert_at(&1, ListHelper.wrap_index(next_i, &1), element))
  end

  defp grove(list), do: [1000, 2000, 3000] |> Enum.map(&coord(list, &1)) |> Enum.sum()

  defp coord(list, index_after_zero) do
    zero_index = Enum.find_index(list, &(elem(&1, 0) == 0))
    index = ListHelper.wrap_index(zero_index + index_after_zero, list)
    list |> Enum.at(index) |> elem(0)
  end
end
