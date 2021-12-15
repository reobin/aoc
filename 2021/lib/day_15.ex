defmodule AoC.Day15 do
  @moduledoc """
  https://adventofcode.com/2021/day/15
  """

  alias AoC.Modules.Grid

  def part_1(input), do: input |> Grid.from_string(is_integer?: true) |> lowest_cost_path()

  def part_2(input) do
    input
    |> Grid.from_string(is_integer?: true)
    |> Grid.expand(5, 5, &increment/2)
    |> lowest_cost_path()
  end

  defp lowest_cost_path(map) do
    {width, height} = Grid.get_size(map)
    target = {width - 1, height - 1}
    compute_cost(%{queue: [{0, {0, 0}}], map: map, found: %{{0, 0} => true}, target: target})
  end

  defp compute_cost(%{queue: [{cost, target} | _rest], target: target}), do: cost

  defp compute_cost(state) do
    [{cost, point} | queue] = state.queue

    state = Map.put(state, :queue, queue)

    point
    |> Grid.get_neighbors(state.map)
    |> Enum.filter(&is_nil(state.found[&1]))
    |> Enum.reduce(state, fn neighbor, state ->
      new_cost = cost + Map.get(state.map, neighbor)

      Map.merge(state, %{
        queue: state.queue ++ [{new_cost, neighbor}],
        found: Map.put(state.found, neighbor, true)
      })
    end)
    |> then(&Map.put(&1, :queue, Enum.sort_by(&1.queue, fn {cost, _point} -> cost end)))
    |> compute_cost()
  end

  defp increment(cell, {dx, dy}), do: get_risk_level(cell + dx + dy)

  defp get_risk_level(value) when value > 9, do: value - 9
  defp get_risk_level(value), do: value
end
