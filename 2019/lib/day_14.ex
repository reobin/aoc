defmodule AoC.Day14 do
  @moduledoc """
  https://adventofcode.com/2019/day/14
  """

  def part_1(input) do
    rules = parse(input)
    {"FUEL", 1} |> produce(rules)
  end

  def part_2(input) do
    rules = parse(input)
    maximize_fuel(0..1_000_000_000_000, 1_000_000_000_000, rules)
  end

  defp maximize_fuel(lower..upper, _goal, _rules) when upper == lower + 1, do: lower

  defp maximize_fuel(lower..upper, goal, rules) do
    middle = div(upper + lower, 2)
    range = if produce({"FUEL", middle}, rules) >= goal, do: lower..middle, else: middle..upper
    maximize_fuel(range, goal, rules)
  end

  defp produce(requirement, rules), do: requirement |> produce(rules, %{}) |> elem(0)
  defp produce({_unit, 0}, _rules, bank), do: {0, bank}

  defp produce({unit, quantity}, rules, bank) when is_map_key(bank, unit) do
    case Map.get(bank, unit) do
      banked when banked < quantity ->
        produce({unit, quantity - banked}, rules, Map.delete(bank, unit))

      banked when banked >= quantity ->
        produce({unit, 0}, rules, Map.put(bank, unit, banked - quantity))
    end
  end

  defp produce({"ORE", quantity}, _rules, bank), do: {quantity, bank}

  defp produce({unit, quantity}, rules, bank) do
    {output_quantity, input} = rules[unit]

    multiplier = if output_quantity < quantity, do: ceil(quantity / output_quantity), else: 1

    leftover = output_quantity * multiplier - quantity

    bank = if leftover > 0, do: Map.update(bank, unit, leftover, &(&1 + leftover)), else: bank

    Enum.reduce(input, {0, bank}, fn {input_unit, unit_quantity}, {requirement, bank} ->
      {new, bank} = produce({input_unit, unit_quantity * multiplier}, rules, bank)
      {new + requirement, bank}
    end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, rules ->
      [_, input, output_quantity, output_unit] = Regex.run(~r/(.+) => (\d+) (\w+)/, line)

      input =
        input
        |> String.split(", ")
        |> Enum.map(&String.split/1)
        |> Enum.map(fn [quantity, unit] -> {unit, String.to_integer(quantity)} end)

      Map.put(rules, output_unit, {String.to_integer(output_quantity), input})
    end)
  end
end
