defmodule AoC.Day03 do
  def part_1(input) do
    [wire_1, wire_2] = input |> String.split("\n", trim: true)

    {points_in_wire_1, _steps_to_points} =
      wire_1 |> parse_instructions() |> get_points_in_instructions()

    {points_in_wire_2, _steps_to_points} =
      wire_2 |> parse_instructions() |> get_points_in_instructions()

    points_in_wire_1
    |> MapSet.intersection(points_in_wire_2)
    |> Enum.map(&compute_manhattan_distance/1)
    |> Enum.min()
  end

  def part_2(input) do
    [wire_1, wire_2] = input |> String.split("\n", trim: true)

    {points_in_wire_1, steps_to_points_wire_1} =
      wire_1 |> parse_instructions() |> get_points_in_instructions()

    {points_in_wire_2, steps_to_points_wire_2} =
      wire_2 |> parse_instructions() |> get_points_in_instructions()

    points_in_wire_1
    |> MapSet.intersection(points_in_wire_2)
    |> Enum.map(fn intersection ->
      steps_to_points_wire_1[intersection] + steps_to_points_wire_2[intersection]
    end)
    |> Enum.min()
  end

  defp compute_manhattan_distance(%{x: x, y: y}), do: abs(x) + abs(y)

  defp get_points_in_instructions(instructions) do
    %{points: points, visits: visits} =
      instructions
      |> Enum.reduce(
        %{step: 0, points: [], current: %{x: 0, y: 0}, visits: %{}},
        fn instruction, %{step: step, points: points, current: current, visits: visits} ->
          new_point = move(current, instruction)

          new_points = get_points_between(current, new_point)

          new_visits =
            new_points
            |> Enum.with_index()
            |> Enum.reduce(%{}, fn {point, index}, visits ->
              Map.merge(visits, %{point => step + index + 1})
            end)

          %{
            step: step + instruction.distance,
            points: points ++ new_points,
            current: new_point,
            visits: Map.merge(new_visits, visits)
          }
        end
      )

    {MapSet.new(points), visits}
  end

  defp get_points_between(point_a, point_b),
    do:
      for(x <- point_a.x..point_b.x, y <- point_a.y..point_b.y, do: %{x: x, y: y})
      |> Enum.filter(fn point -> point != point_a end)

  defp move(point, %{direction: "U", distance: distance}),
    do: Map.put(point, :y, point.y - distance)

  defp move(point, %{direction: "R", distance: distance}),
    do: Map.put(point, :x, point.x + distance)

  defp move(point, %{direction: "D", distance: distance}),
    do: Map.put(point, :y, point.y + distance)

  defp move(point, %{direction: "L", distance: distance}),
    do: Map.put(point, :x, point.x - distance)

  defp move(point, _instruction), do: point

  defp parse_instructions(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(fn instruction ->
      [_match, direction, distance] = Regex.run(~r/(U|R|D|L)(\d+)/, instruction)
      %{direction: direction, distance: String.to_integer(distance)}
    end)
  end
end
