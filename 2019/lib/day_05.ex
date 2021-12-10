defmodule AoC.Day05 do
  @moduledoc """
  https://adventofcode.com/2019/day/5
  """

  alias AoC.Modules.Intcode

  def part_1(input), do: input |> Intcode.get_program() |> Intcode.run(1)
  def part_2(input), do: input |> Intcode.get_program() |> Intcode.run(5)
end
