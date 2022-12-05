defmodule AoC.Day05 do
  @moduledoc """
  https://adventofcode.com/2022/day/5
  """

  alias AoC.Modules.Stack

  def part_1(input) do
    {stacks, instructions} = parse(input)

    instructions
    |> Enum.reduce(stacks, &move(&1, &2, :cm9000))
    |> Map.values()
    |> Enum.map(&Stack.top/1)
    |> Enum.join()
  end

  def part_2(input) do
    {stacks, instructions} = parse(input)

    instructions
    |> Enum.reduce(stacks, &move(&1, &2, :cm9001))
    |> Map.values()
    |> Enum.map(&Stack.top/1)
    |> Enum.join()
  end

  defp move({0, _from, _to}, stacks, :cm9000), do: stacks

  defp move({quantity, from, to}, stacks, :cm9000) do
    {top, rest_from} = stacks |> Map.get(from) |> Stack.pop()
    new_to = stacks |> Map.get(to) |> Stack.push(top)
    stacks = stacks |> Map.put(from, rest_from) |> Map.put(to, new_to)
    move({quantity - 1, from, to}, stacks, :cm9000)
  end

  defp move({quantity, from, to}, stacks, :cm9001) do
    {top, rest_from} = stacks |> Map.get(from) |> Stack.pop(quantity)
    new_to = stacks |> Map.get(to) |> Stack.push(top)
    stacks |> Map.put(from, rest_from) |> Map.put(to, new_to)
  end

  defp parse(input) do
    input
    |> String.split("\n\n")
    |> then(fn [stacks, instructions] ->
      {parse_stacks(stacks), parse_instructions(instructions)}
    end)
  end

  defp parse_stacks(stacks) do
    stack_count = stacks |> String.replace(~r/[^\d+]/, "") |> String.length()

    1..stack_count
    |> Enum.reduce(%{}, fn id, acc -> Map.put(acc, id, build_stack(stacks, id)) end)
  end

  defp build_stack(stacks, id) do
    stacks
    |> String.split("\n")
    |> Enum.map(&String.at(&1, 4 * (id - 1) + 1))
    |> Enum.reject(&is_nil/1)
    |> Enum.filter(&String.match?(&1, ~r/[A-Z]/))
  end

  defp parse_instructions(instructions) do
    instructions |> String.split("\n") |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction(instruction) do
    instruction
    |> String.split(" ")
    |> then(fn [_, quantity, _, from, _, to] ->
      {String.to_integer(quantity), String.to_integer(from), String.to_integer(to)}
    end)
  end
end
