defmodule AoC.Day15 do
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

  alias AoC.Modules.Grid
  alias AoC.Modules.Intcode

  def part_1(input) do
    map = build_map(input)
    target = map |> Grid.get_points() |> Enum.find(&(map[&1] == @target))
    shortest_path(map, {0, 0}, target)
  end

  def part_2(input) do
    map = build_map(input)
    target = map |> Grid.get_points() |> Enum.find(&(map[&1] == @target))

    map
    |> Grid.get_points()
    |> Enum.filter(&(map[&1] == "."))
    |> Enum.map(&shortest_path(map, target, &1))
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

  defp shortest_path(map, from, to),
    do: shortest_path(%{map: map, queue: [{0, from}], found: %{{0, 0} => true}, target: to})

  defp shortest_path(%{queue: []}), do: 0
  defp shortest_path(%{queue: [{cost, target} | _queue], target: target}), do: cost

  defp shortest_path(%{queue: [{cost, point} | queue]} = state) do
    point
    |> Grid.get_neighbors(state.map)
    |> Enum.filter(&(is_nil(state.found[&1]) and state.map[&1] != @wall))
    |> Enum.reduce(
      Map.put(state, :queue, queue),
      fn neighbor, %{queue: queue, found: found} = state ->
        state
        |> Map.put(:queue, queue ++ [{cost + 1, neighbor}])
        |> Map.put(:found, Map.put(found, neighbor, true))
      end
    )
    |> then(&Map.put(&1, :queue, Enum.sort_by(&1.queue, fn {cost, _point} -> cost end)))
    |> shortest_path()
  end
end
