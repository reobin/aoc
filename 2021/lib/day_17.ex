defmodule AoC2021.Day17 do
  @moduledoc """
  https://adventofcode.com/2021/day/17
  """

  def part_1(input) do
    input
    |> get_target()
    |> hitting_velocities()
    |> Enum.map(&(&1 |> high_point() |> elem(1)))
    |> Enum.max()
  end

  def part_2(input), do: input |> get_target() |> hitting_velocities() |> Enum.count()

  defp hitting_velocities({_..x2, y1.._} = target),
    do: for(x <- 1..x2, y <- abs(y1)..y1, do: {x, y}) |> Enum.filter(&launch_hits?(&1, target))

  defp launch_hits?(velocity, target), do: launch_hits?({0, 0}, velocity, target)
  defp launch_hits?({x, y}, _v, {_..x2, y1.._}) when x > x2 or y < y1, do: false
  defp launch_hits?({x, y}, _v, {x1..x2, y1..y2}) when x in x1..x2 and y in y1..y2, do: true

  defp launch_hits?({x, y}, {vx, vy} = velocity, target),
    do: launch_hits?({x + vx, y + vy}, next_velocity(velocity), target)

  defp high_point(velocity), do: high_point({0, 0}, velocity)
  defp high_point(point, {_, vy}) when vy < 0, do: point
  defp high_point({x, y}, {vx, vy}), do: high_point({x + vx, y + vy}, next_velocity({vx, vy}))

  defp next_velocity({x, y}), do: {next_velocity(x, :x), next_velocity(y, :y)}
  defp next_velocity(0, :x), do: 0
  defp next_velocity(vx, :x) when vx < 0, do: vx + 1
  defp next_velocity(vx, :x), do: vx - 1
  defp next_velocity(vy, :y), do: vy - 1

  defp get_target(input) do
    [_ | match_groups] = Regex.run(~r/x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)$/, input)

    match_groups
    |> Enum.map(&String.to_integer/1)
    |> then(fn [x1, x2, y1, y2] -> {x1..x2, y1..y2} end)
  end
end
