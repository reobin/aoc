defmodule AoC.Day01 do
  @moduledoc """
  https://adventofcode.com/2018/day/1
  """

  def part_1(input) do
    input |> String.split("\n") |> Enum.map(&String.to_integer/1) |> Enum.sum()
  end

  def part_2(input) do
    list = input |> String.split("\n") |> Enum.map(&String.to_integer/1)
    find_first_duplicate(%{list: list, duplicate: nil, sum: 0, seen: %{0 => true}})
  end

  defp find_first_duplicate(%{duplicate: d}) when not is_nil(d), do: d

  defp find_first_duplicate(%{list: list} = state),
    do: list |> Enum.reduce_while(state, &add/2) |> find_first_duplicate()

  defp add(x, %{sum: sum, seen: seen} = state) do
    state =
      state
      |> Map.put(:sum, sum + x)
      |> Map.put(:seen, Map.put(seen, sum + x, true))
      |> Map.put(:duplicate, if(Map.get(seen, sum + x), do: sum + x, else: nil))

    if is_nil(state.duplicate), do: {:cont, state}, else: {:halt, state}
  end
end
