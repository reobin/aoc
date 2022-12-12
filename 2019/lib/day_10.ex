defmodule AoC2019.Day10 do
  @moduledoc """
  https://adventofcode.com/2019/day/10
  """

  alias AoC.Grid
  alias AoC.Point

  def part_1(input) do
    map = input |> Grid.from_string(column_divider: "")

    map
    |> Grid.points()
    |> Enum.filter(&(Grid.get(map, &1, ".") == "#"))
    |> Enum.map(&count_detections(&1, map))
    |> Enum.max()
  end

  def part_2(input) do
    map = input |> Grid.from_string(column_divider: "")

    {station_x, station_y} =
      map
      |> Grid.points()
      |> Enum.filter(&(Grid.get(map, &1, ".") == "#"))
      |> Enum.max_by(&count_detections(&1, map))

    {target_x, target_y} =
      0..10000
      |> Enum.reduce_while({map, [], 0}, fn _, {map, detected, count} ->
        new_detected =
          map
          |> Grid.points()
          |> Enum.filter(&is_detected?({station_x, station_y}, &1, map))
          |> sort_by_angle({station_x, station_y})

        state = {
          new_detected |> Enum.reduce(map, fn asteroid, map -> Grid.set(map, asteroid, ".") end),
          detected ++ new_detected,
          count + Enum.count(new_detected)
        }

        if elem(state, 2) >= 200, do: {:halt, state}, else: {:cont, state}
      end)
      |> elem(1)
      |> Enum.at(199)

    target_x * 100 + target_y
  end

  defp count_detections(point, map),
    do: map |> Grid.points() |> Enum.count(&is_detected?(point, &1, map))

  defp is_detected?(station, target, map) do
    station != target and Grid.get(map, target, ".") != "." and
      station |> Point.between(target) |> Enum.all?(&(Grid.get(map, &1, ".") == "."))
  end

  defp sort_by_angle(asteroids, {station_x, station_y}) do
    Enum.sort_by(asteroids, fn {target_x, target_y} ->
      v = :math.atan2(target_x - station_x, target_y - station_y)
      {v < 0, -v}
    end)
  end
end
