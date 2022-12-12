defmodule AoC2019.Day11 do
  @moduledoc """
  https://adventofcode.com/2019/day/11
  """

  alias AoC.Grid
  alias AoC2019.Modules.Intcode

  def part_1(input), do: input |> Intcode.initialize() |> run(:part_1) |> Enum.count()
  def part_2(input), do: input |> Intcode.initialize() |> run(:part_2) |> Grid.to_string()

  defp run(program, :part_1), do: run(program, {0, 0}, :up, %{}, 1)
  defp run(program, :part_2), do: run(program, {0, 0}, :up, %{{0, 0} => "#"}, 1)

  defp run(program, position, direction, map, step) when rem(step, 2) == 1 do
    program = Intcode.run(program, [input(map, position)])

    if program.output == :halt do
      map
    else
      map = Map.put(map, position, paint(program.output))
      run(program, position, direction, map, step + 1)
    end
  end

  defp run(program, position, direction, map, step) do
    program = Intcode.run(program)

    if program.output == :halt do
      map
    else
      direction = turn(direction, program.output)
      position = move(position, direction)
      run(program, position, direction, map, step + 1)
    end
  end

  defp input(map, position), do: if(Map.get(map, position, ".") == ".", do: 0, else: 1)

  defp paint(0), do: "."
  defp paint(1), do: "#"

  defp turn(:up, 0), do: :left
  defp turn(:up, 1), do: :right
  defp turn(:right, 0), do: :up
  defp turn(:right, 1), do: :down
  defp turn(:down, 0), do: :right
  defp turn(:down, 1), do: :left
  defp turn(:left, 0), do: :down
  defp turn(:left, 1), do: :up

  defp move({x, y}, :up), do: {x, y - 1}
  defp move({x, y}, :right), do: {x + 1, y}
  defp move({x, y}, :down), do: {x, y + 1}
  defp move({x, y}, :left), do: {x - 1, y}
end
