defmodule AoC.Day06 do
  @life_span 8

  def part_1(input, day_count \\ 80), do: get_state_after(input, day_count)
  def part_2(input, day_count \\ 256), do: get_state_after(input, day_count)

  defp get_state_after(input, day_count) do
    1..day_count
    |> Enum.reduce(get_state(input), &pass_day/2)
    |> Map.values()
    |> Enum.sum()
  end

  defp pass_day(_day, state), do: @life_span..0 |> Enum.reduce(state, &update(&1, &2, state))

  defp update(8, state, ref), do: Map.put(state, 8, Map.get(ref, 0, 0))
  defp update(6, state, ref), do: Map.put(state, 6, Map.get(ref, 0, 0) + Map.get(ref, 7, 0))
  defp update(day, state, ref), do: Map.put(state, day, Map.get(ref, day + 1, 0))

  defp get_state(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.frequencies()
    |> Map.new(fn {k, v} -> {String.to_integer(k), v} end)
  end
end
