defmodule AoC2019.Day17 do
  @moduledoc """
  https://adventofcode.com/2019/day/17
  """

  alias AoC.Grid

  alias AoC2019.Modules.Intcode

  def part_1(input) do
    map =
      input
      |> Intcode.initialize()
      |> Intcode.run_until_halt()
      |> List.to_string()
      |> Grid.from_string()

    map
    |> Grid.points()
    |> Enum.filter(&intersection?(map, &1))
    |> Enum.map(&(elem(&1, 0) * elem(&1, 1)))
    |> Enum.sum()
  end

  defp intersection?(map, point) do
    neighbors = Grid.neighbors(point, map)
    Enum.count(neighbors) == 4 and Enum.all?(neighbors, &(Grid.get(map, &1) == "#"))
  end

  def part_2(input) do
    input = input |> String.codepoints() |> Enum.drop(1)
    input = ["2" | input] |> Enum.join("")
    program = Intcode.initialize(input)

    # L,12,R,4,R,4,L,6,L,12,R,4,R,4,R,12,L,12,R,4,R,4,L,6,L,10,L,6,R,4,L,12,R,4,R,4,L,6,L,12,R,4,R,4,R,12,L,10,L,6,R,4,L,12,R,4,R,4,R,12,L,10,L,6,R,4,L,12,R,4,R,4,L,6

    # A=L,12,R,4,R,4,L,6
    # B=L,12,R,4,R,4,R,12
    # C=L,10,L,6,R,4

    # A,B,A,C,A,B,C,B,C,A

    input = 'A,B,A,C,A,B,C,B,C,A\nL,12,R,4,R,4,L,6\nL,12,R,4,R,4,R,12\nL,10,L,6,R,4\nn\n'

    program
    |> Intcode.run_until_halt(input)
    |> List.last()
  end
end
