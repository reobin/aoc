defmodule AoC2022.Day11 do
  @moduledoc """
  https://adventofcode.com/2022/day/11
  """

  @round_count_part_1 20
  @round_count_part_2 10_000

  def part_1(input), do: input |> parse() |> start(:part_1) |> monkey_business()
  def part_2(input), do: input |> parse() |> start(:part_2) |> monkey_business()

  defp monkey_business(state) do
    state
    |> Enum.map(fn {_, monkey} -> monkey.count end)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  defp start(state, part), do: start(state, 0, 0, part)
  defp start(state, @round_count_part_1, _index, :part_1), do: state
  defp start(state, @round_count_part_2, _index, :part_2), do: state

  defp start(state, round, index, part) when map_size(state) == index,
    do: start(state, round + 1, 0, part)

  defp start(state, round, index, part) do
    state
    |> Map.get(index)
    |> Map.get(:items)
    |> Enum.reduce(state, &inspect(&2, &1, index, part))
    |> start(round, index + 1, part)
  end

  defp inspect(state, item, index, part) do
    monkey = Map.get(state, index)
    item = operate(monkey, item, part)
    recipient_index = if rem(item, monkey.test) == 0, do: monkey.if_true, else: monkey.if_false
    transfer(state, index, recipient_index, item)
  end

  defp operate(monkey, item, :part_1), do: operate(monkey, item) |> div(3) |> floor()
  defp operate(monkey, item, :part_2), do: operate(monkey, item) |> rem(monkey.dividor)
  defp operate(monkey, item), do: monkey.operation |> Code.eval_string(old: item) |> elem(0)

  defp transfer(state, from, to, item) do
    [_item | items] = state |> Map.get(from) |> Map.get(:items)

    source = state |> Map.get(from) |> Map.put(:items, items) |> Map.update(:count, 1, &(&1 + 1))
    recipient = state |> Map.get(to) |> Map.update(:items, [item], &(&1 ++ [item]))

    state |> Map.put(from, source) |> Map.put(to, recipient)
  end

  defp parse(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&initialize_monkey/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {monkey, index}, state -> Map.put(state, index, monkey) end)
    |> add_dividor()
  end

  defp add_dividor(state) do
    dividor = state |> Enum.map(fn {_, monkey} -> monkey.test end) |> Enum.product()

    state
    |> Enum.reduce(%{}, fn {i, monkey}, state ->
      Map.put(state, i, Map.put(monkey, :dividor, dividor))
    end)
  end

  defp initialize_monkey(value) do
    lines = String.split(value, "\n")

    %{
      items: lines |> Enum.at(1) |> parse_items(),
      operation: lines |> Enum.at(2) |> parse_operation(),
      test: lines |> Enum.at(3) |> parse_test(),
      if_true: lines |> Enum.at(4) |> parse_if_true(),
      if_false: lines |> Enum.at(5) |> parse_if_false()
    }
  end

  defp parse_items(s),
    do: s |> String.replace(~r/[^\d,]/, "") |> String.split(",") |> Enum.map(&String.to_integer/1)

  defp parse_operation(s), do: s |> String.split(": ") |> List.last()
  defp parse_test(s), do: s |> String.split("by ") |> List.last() |> String.to_integer()
  defp parse_if_true(s), do: s |> String.split("monkey ") |> List.last() |> String.to_integer()
  defp parse_if_false(s), do: s |> String.split("monkey ") |> List.last() |> String.to_integer()
end
