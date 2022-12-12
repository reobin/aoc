defmodule AoC2019.Day15 do
  @moduledoc """
  https://adventofcode.com/2019/day/15
  """

  @north 1
  @east 4
  @south 2
  @west 3

  @directions [@north, @east, @south, @west]

  @wall_hit 0
  @move 1
  @target_hit 2

  @wall "#"
  @floor "."
  @target "8"

  alias AoC.Grid
  alias AoC2019.Modules.Intcode

  def part_1(input) do
    map = build_map(input)
    target = map |> Grid.points() |> Enum.find(&(map[&1] == @target))
    Grid.shortest_path(map, {0, 0}, target, can_move?: &can_move?/3)
  end

  def part_2(input) do
    map = build_map(input)
    target = map |> Grid.points() |> Enum.find(&(map[&1] == @target))

    map
    |> Grid.points()
    |> Enum.filter(&(map[&1] == "."))
    |> Enum.map(fn point -> Grid.shortest_path(map, target, point, can_move?: &can_move?/3) end)
    |> Enum.max()
  end

  defp build_map(input), do: input |> Intcode.initialize() |> scan({0, 0}, %{}, 0)

  defp scan(state, position, map, step),
    do: Enum.reduce(@directions, map, &evaluate(state, next(position, &1), &1, &2, step))

  defp evaluate(_state, position, _direction, map, _step) when is_map_key(map, position), do: map

  defp evaluate(state, position, direction, map, step) do
    state = Intcode.run(state, [direction])

    case state.output do
      @wall_hit -> Grid.set(map, position, @wall)
      @move -> scan(state, position, Grid.set(map, position, @floor), step + 1)
      @target_hit -> Grid.set(map, position, @target)
    end
  end

  defp next({x, y}, @north), do: {x, y - 1}
  defp next({x, y}, @east), do: {x + 1, y}
  defp next({x, y}, @south), do: {x, y + 1}
  defp next({x, y}, @west), do: {x - 1, y}

  defp can_move?(map, _from, to), do: Grid.get(map, to) != @wall
end
