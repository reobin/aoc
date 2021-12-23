defmodule AoC.Day22 do
  @moduledoc """
  https://adventofcode.com/2021/day/22
  """

  def part_1(input), do: input |> parse() |> Enum.filter(&near?(&1.range)) |> compute_cubes()
  def part_2(input), do: input |> parse() |> compute_cubes()

  defp near?({x1..x2, y1..y2, z1..z2}) do
    range = -50..50
    (x1 in range or x2 in range) and (y1 in range or y2 in range) and (z1 in range or z2 in range)
  end

  defp compute_cubes(instructions) do
    instructions
    |> Enum.reduce([], fn instruction, cubes ->
      cubes = add_intersection_inverts(cubes, instruction)
      if instruction.value == 1, do: cubes ++ [instruction], else: cubes
    end)
    |> Enum.map(fn cube -> volume(cube.range) * cube.value end)
    |> Enum.sum()
  end

  defp add_intersection_inverts(cubes, instruction) do
    Enum.reduce(cubes, cubes, fn cube, cubes ->
      if overlaps?(instruction.range, cube.range) do
        cubes ++ [%{range: intersection(cube.range, instruction.range), value: -cube.value}]
      else
        cubes
      end
    end)
  end

  defp overlaps?({xa, ya, za}, {xb, yb, zb}) do
    not Range.disjoint?(xa, xb) and not Range.disjoint?(ya, yb) and not Range.disjoint?(za, zb)
  end

  defp intersection({xa1..xa2, ya1..ya2, za1..za2}, {xb1..xb2, yb1..yb2, zb1..zb2}) do
    {max(xa1, xb1)..min(xa2, xb2), max(ya1, yb1)..min(ya2, yb2), max(za1, zb1)..min(za2, zb2)}
  end

  defp volume({x1..x2, y1..y2, z1..z2}), do: (x2 - x1 + 1) * (y2 - y1 + 1) * (z2 - z1 + 1)

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [_ | coordinates] = Regex.run(~r/x=(.+)\.\.(.+),y=(.+)\.\.(.+),z=(.+)\.\.(.+)/, line)
      [x1, x2, y1, y2, z1, z2] = Enum.map(coordinates, &String.to_integer/1)

      %{
        value: if(String.contains?(line, "on"), do: 1, else: 0),
        range: {x1..x2, y1..y2, z1..z2}
      }
    end)
  end
end
