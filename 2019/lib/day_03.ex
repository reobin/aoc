defmodule AoC.Day03 do
  @moduledoc """
  https://adventofcode.com/2019/day/3
  """

  alias AoC.Modules.Point

  def part_1(input) do
    [wire_1, wire_2] = get_wires(input)

    {points_in_wire_1, _steps_to_points} = get_points(wire_1)
    {points_in_wire_2, _steps_to_points} = get_points(wire_2)

    points_in_wire_1
    |> MapSet.intersection(points_in_wire_2)
    |> Enum.map(&Point.compute_manhattan_distance/1)
    |> Enum.min()
  end

  def part_2(input) do
    [wire_1, wire_2] = get_wires(input)

    {points_in_wire_1, steps_to_points_wire_1} = get_points(wire_1)
    {points_in_wire_2, steps_to_points_wire_2} = get_points(wire_2)

    points_in_wire_1
    |> MapSet.intersection(points_in_wire_2)
    |> Enum.map(fn intersection ->
      steps_to_points_wire_1[intersection] + steps_to_points_wire_2[intersection]
    end)
    |> Enum.min()
  end

  defp get_points(wire) do
    %{points: points, visits: visits} =
      wire
      |> Enum.reduce(
        %{step: 0, points: [], current: {0, 0}, visits: %{}},
        fn {_direction, distance} = instruction,
           %{step: step, points: points, current: current, visits: visits} ->
          new_point = move(current, instruction)

          new_points = get_points_between(current, new_point)

          new_visits =
            new_points
            |> Enum.with_index()
            |> Enum.reduce(%{}, fn {point, index}, visits ->
              Map.merge(visits, %{point => step + index + 1})
            end)

          %{
            step: step + distance,
            points: points ++ new_points,
            current: new_point,
            visits: Map.merge(new_visits, visits)
          }
        end
      )

    {MapSet.new(points), visits}
  end

  defp get_points_between({x_a, y_a} = point_a, {x_b, y_b}),
    do: for(x <- x_a..x_b, y <- y_a..y_b, do: {x, y}) |> Enum.filter(&(&1 != point_a))

  defp move({x, y}, {"U", distance}), do: {x, y - distance}
  defp move({x, y}, {"R", distance}), do: {x + distance, y}
  defp move({x, y}, {"D", distance}), do: {x, y + distance}
  defp move({x, y}, {"L", distance}), do: {x - distance, y}

  defp get_wires(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn wire ->
      wire
      |> String.split(",", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.map(fn [direction | instruction] ->
        {direction, instruction |> Enum.join("") |> String.to_integer()}
      end)
    end)
  end
end
