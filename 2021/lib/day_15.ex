defmodule AoC.Day15 do
  @moduledoc """
  https://adventofcode.com/2021/day/15
  """

  alias AoC.Modules.Grid

  def part_1(input), do: input |> Grid.from_string(is_integer?: true) |> lowest_risk_path()

  def part_2(input) do
    input
    |> Grid.from_string(is_integer?: true)
    |> Grid.expand(5, 5, &increment/2)
    |> lowest_risk_path()
  end

  defp lowest_risk_path(map) do
    {width, height} = Grid.get_size(map)
    target = {width - 1, height - 1}
    compute_risk(%{queue: [{0, 0}], map: map, costs: %{{0, 0} => 0}, target: target})
  end

  defp compute_risk(%{queue: []} = state), do: Map.get(state.costs, state.target)

  defp compute_risk(state) do
    [point | queue] = state.queue

    state = Map.put(state, :queue, queue)

    point
    |> Grid.get_neighbors(state.map)
    |> Enum.reduce(state, fn neighbor, state ->
      old_cost = Map.get(state.costs, neighbor, :infinity)
      new_cost = Map.get(state.costs, point) + Map.get(state.map, neighbor)

      if new_cost < old_cost do
        Map.merge(state, %{
          queue: state.queue ++ [neighbor],
          costs: Map.put(state.costs, neighbor, new_cost)
        })
      else
        state
      end
    end)
    |> compute_risk()
  end

  defp increment(cell, {dx, dy}), do: get_risk_level(cell + dx + dy)

  defp get_risk_level(value) when value > 9, do: value - 9
  defp get_risk_level(value), do: value
end
