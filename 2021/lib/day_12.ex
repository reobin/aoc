defmodule AoC.Day12 do
  @moduledoc """
  https://adventofcode.com/2021/day/12
  """

  alias AoC.Modules.String, as: StringHelper

  def part_1(input), do: input |> get_path_options() |> count_paths(allowed_doubles: 0)
  def part_2(input), do: input |> get_path_options() |> count_paths(allowed_doubles: 1)

  defp count_paths(paths, options), do: count_paths(paths, "start", %{}, options)
  defp count_paths(_paths, "end", _path, _options), do: 1

  defp count_paths(paths, from, path, options) do
    path = Map.put(path, from, Map.get(path, from, 0) + 1)

    paths
    |> Map.get(from, [])
    |> Enum.filter(&is_allowed?(&1, Map.update(path, &1, 1, fn c -> c + 1 end), options))
    |> Enum.map(&count_paths(paths, &1, path, options))
    |> Enum.sum()
  end

  defp is_allowed?(cave, path, allowed_doubles: allowed_doubles),
    do: is_big?(cave) or (Map.get(path, cave) <= 2 and count_doubles(path) <= allowed_doubles)

  defp count_doubles(path), do: path |> Map.keys() |> Enum.count(&is_double?(&1, path))

  defp is_double?(cave, path), do: not is_big?(cave) and path[cave] > 1

  defp is_big?(cave), do: not StringHelper.is_lower_case?(cave)

  defp get_path_options(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.reduce(%{}, fn [from, to], paths ->
      [{from, to}, {to, from}]
      |> Enum.filter(&is_path_allowed?/1)
      |> Enum.reduce(paths, fn {from, to}, paths ->
        Map.put(paths, from, Enum.concat(Map.get(paths, from, []), [to]))
      end)
    end)
  end

  defp is_path_allowed?({"end", _to}), do: false
  defp is_path_allowed?({_from, "start"}), do: false
  defp is_path_allowed?({_from, _to}), do: true
end
