defmodule AoC2022.Day15 do
  @moduledoc """
  https://adventofcode.com/2022/day/15
  """

  alias AoC.Point

  def part_1(input, row \\ 2_000_000) do
    info = parse(input)

    min_x = info |> Enum.map(fn {{x, _y}, _b, d} -> x - d end) |> Enum.min()
    max_x = info |> Enum.map(fn {{x, _y}, _b, d} -> x + d end) |> Enum.max()

    min_x..max_x |> Enum.count(&(not can_be_beacon?({&1, row}, info)))
  end

  def part_2(input, max \\ 4_000_000) do
    info = parse(input)

    {0, 0} |> lost_beacon(info, max) |> then(fn {x, y} -> x * 4_000_000 + y end)
  end

  defp lost_beacon({x, y}, info, max) when x > max, do: lost_beacon({0, y + 1}, info, max)
  defp lost_beacon({_x, y}, _info, max) when y > max, do: nil

  defp lost_beacon({x, y}, info, max) do
    if lost_beacon?({x, y}, info),
      do: {x, y},
      else: {x, y} |> next_unknown_point(info) |> lost_beacon(info, max)
  end

  defp next_unknown_point({x, y} = point, info) do
    {s, _b, d} = furthest_scanner_in_range(info, point)
    {skip_scanner({x, y}, s, d), y}
  end

  defp skip_scanner({x, y}, scanner, goal) do
    d = Point.manhattan_distance({x, y}, scanner)
    if d >= goal, do: x + 1, else: skip_scanner({x + goal - d, y}, scanner, goal)
  end

  defp furthest_scanner_in_range(info, point) do
    info
    |> Enum.filter(&(Point.manhattan_distance(elem(&1, 0), point) <= elem(&1, 2)))
    |> Enum.max_by(&Point.manhattan_distance(elem(&1, 0), point))
  end

  defp lost_beacon?(p, info), do: not known_beacon?(p, info) and can_be_beacon?(p, info)

  defp can_be_beacon?(p, info) do
    known_beacon?(p, info) or
      not Enum.any?(info, fn {s, _b, d} -> Point.manhattan_distance(s, p) <= d end)
  end

  defp known_beacon?(p, info), do: info |> Enum.any?(fn {_s, b, _d} -> b == p end)

  defp parse(i), do: i |> String.split("\n") |> Enum.map(&parse_line/1)
  defp parse_line(l), do: l |> String.split(": ") |> Enum.map(&parse_coord/1) |> add_distance()
  defp parse_coord(c), do: c |> String.split(", ") |> Enum.map(&parse_number/1) |> to_coord()
  defp parse_number(n), do: n |> String.replace(~r/[^0-9-]/, "") |> String.to_integer()
  defp add_distance([a, b]), do: {a, b, Point.manhattan_distance(a, b)}
  defp to_coord([x, y]), do: {x, y}
end
