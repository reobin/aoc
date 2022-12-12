defmodule AoC2019.Day05 do
  @moduledoc """
  https://adventofcode.com/2019/day/5
  """

  alias AoC2019.Modules.Intcode

  def part_1(input), do: input |> Intcode.initialize() |> Intcode.run([1]) |> Map.get(:output)
  def part_2(input), do: input |> Intcode.initialize() |> Intcode.run([5]) |> Map.get(:output)
end
