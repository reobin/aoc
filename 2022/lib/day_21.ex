defmodule AoC2022.Day21 do
  @moduledoc """
  https://adventofcode.com/2022/day/21
  """

  def part_1(input) do
    instructions = parse(input)
    instructions |> initialize() |> run(instructions) |> Enum.sum()
  end

  @min 2_000_000_000_000
  @max 5_000_000_000_000

  def part_2(input) do
    instructions = parse(input)
    instructions |> initialize() |> solve(instructions, @min, @max)
  end

  defp solve(state, instructions, min, max) do
    humn = ((min + max) / 2) |> trunc()
    state = Map.put(state, "humn", humn)

    case run(state, instructions) do
      [a, a] -> humn
      [a, b] when a > b -> solve(state, instructions, humn, max)
      [a, b] when a < b -> solve(state, instructions, min, humn)
    end
  end

  defp initialize(expression),
    do: expression |> Enum.filter(&String.match?(&1, ~r/\w+ = \d+/)) |> Enum.reduce(%{}, &eval/2)

  defp run(%{"jsrw" => a, "ptvl" => b}, _), do: [a, b]

  defp run(state, instructions) do
    instructions
    |> Enum.map(fn i -> {i, Regex.run(~r/\w+ = (\w+) . (\w+)/, i)} end)
    |> Enum.filter(&match?({_, [_, _, _]}, &1))
    |> Enum.filter(fn {_, [_, a, b]} -> not is_nil(state[a]) and not is_nil(state[b]) end)
    |> Enum.map(fn {i, [_, a, b]} ->
      i |> String.replace(a, to_string(state[a])) |> String.replace(b, to_string(state[b]))
    end)
    |> Enum.reduce(state, &eval/2)
    |> run(instructions)
  end

  defp eval(expression, state) do
    variable = expression |> String.split(" = ") |> Enum.at(0)
    {value, _} = Code.eval_string(expression)
    Map.put(state, variable, floor(value))
  end

  defp parse(input), do: input |> String.split("\n") |> Enum.map(&parse_line/1)
  defp parse_line(line), do: line |> String.split(": ") |> then(fn [a, b] -> "#{a} = #{b}" end)
end
