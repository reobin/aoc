defmodule AoC.Day06 do
  @moduledoc """
  https://adventofcode.com/2022/day/6
  """

  alias AoC.Modules.List

  def part_1(input), do: solve(input, 4)
  def part_2(input), do: solve(input, 14)

  defp solve(input, size) do
    input
    |> String.codepoints()
    |> Enum.chunk_every(size, 1)
    |> Enum.find_index(&List.unique?/1)
    |> then(&(&1 + size))
  end
end
