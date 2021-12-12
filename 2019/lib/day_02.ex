defmodule AoC.Day02 do
  @moduledoc """
  https://adventofcode.com/2019/day/2
  """

  alias AoC.Modules.Intcode

  def part_1(input), do: input |> Intcode.initialize() |> get_output(noun: 12, verb: 2)

  def part_2(input) do
    {noun, verb} = input |> Intcode.initialize() |> find_noun_and_verb(19_690_720)
    100 * noun + verb
  end

  defp find_noun_and_verb(program, target) do
    for(noun <- 0..99, verb <- 0..99, do: {noun, verb})
    |> Enum.find(fn {noun, verb} -> get_output(program, noun: noun, verb: verb) == target end)
  end

  defp get_output(program, noun: noun, verb: verb) do
    program
    |> Map.put(1, noun)
    |> Map.put(2, verb)
    |> Intcode.run()
    |> Map.get(:program)
    |> Map.get(0)
  end
end
