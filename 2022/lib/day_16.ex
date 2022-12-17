defmodule AoC2022.Day16 do
  @moduledoc """
  https://adventofcode.com/2022/day/16
  """

  use Memoize

  def part_1(input) do
    valves = parse(input)
    solve(%{valves: valves, me: "AA", previous_me: nil, pressure: 0, minutes: 30})
  end

  def part_2(input) do
    valves = parse(input)
    solve(%{valves: valves, me: "AA", elephant: "AA", pressure: 0, minutes: 26})
  end

  defp solve(%{minutes: 0, pressure: pressure}), do: pressure

  defp solve(state) do
    Memoize.Cache.get_or_run({__MODULE__, :resolve, [cache_key(state)]}, fn ->
      state = state |> increment_pressure() |> Map.put(:minutes, state.minutes - 1)

      if all_open?(state.valves),
        do: solve(state),
        else:
          state
          |> choose(:me)
          |> Enum.map(&choose(&1, :elephant))
          |> List.flatten()
          |> Enum.uniq()
          |> Enum.map(&solve/1)
          |> Enum.max()
    end)
  end

  defp cache_key(state), do: {state.me, Map.get(state, :elephant), state.pressure, state.minutes}

  defp choose(state, key) do
    cond do
      not Map.has_key?(state, key) -> state
      is_open?(Map.get(state.valves, state[key])) -> tunnel(state, key)
      true -> List.flatten([open(state, key), tunnel(state, key)])
    end
  end

  defp open(state, key) do
    name = Map.get(state, key)
    valve = Map.get(state.valves, name)
    Map.put(state, :valves, Map.put(state.valves, name, %{valve | state: :open}))
  end

  defp tunnel(state, key) do
    name = Map.get(state, key)
    value = Map.get(state.valves, name)
    neighbors = value.neighbors

    neighbors |> Enum.map(fn neighbor -> state |> Map.put(key, neighbor) end)
  end

  defp all_open?(valves), do: valves |> Map.values() |> Enum.all?(&is_open?/1)
  defp is_open?(%{flow_rate: 0}), do: true
  defp is_open?(%{state: :open}), do: true
  defp is_open?(_), do: false

  defp increment_pressure(%{valves: valves} = state) do
    inc =
      valves
      |> Map.values()
      |> Enum.filter(&(&1.state == :open))
      |> Enum.map(& &1.flow_rate)
      |> Enum.sum()

    Map.update!(state, :pressure, &(&1 + inc))
  end

  defp parse(input), do: input |> String.split("\n") |> Enum.reduce(%{}, &parse_line/2)

  defp parse_line(line, valves) do
    [valve, rest] = line |> String.trim_leading("Valve ") |> String.split(" has flow rate=")
    [flow_rate, rest] = rest |> String.split(~r/; tunnels? leads? to valves? /)
    tunnels = rest |> String.split(", ")

    Map.put(valves, valve, %{
      name: valve,
      flow_rate: String.to_integer(flow_rate),
      neighbors: tunnels,
      state: :closed
    })
  end
end
