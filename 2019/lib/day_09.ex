defmodule AoC.Day09 do
  @moduledoc """
  https://adventofcode.com/2019/day/9
  """

  alias AoC.Modules.Intcode

  def part_1(input), do: input |> Intcode.initialize() |> Intcode.run([1]) |> Map.get(:output)
  def part_2(input), do: input |> Intcode.initialize() |> Intcode.run([2]) |> Map.get(:output)
end
