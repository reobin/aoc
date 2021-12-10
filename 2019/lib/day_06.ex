defmodule AoC.Day06 do
  @moduledoc """
  https://adventofcode.com/2019/day/6
  """

  @center_of_mass "COM"
  @you "YOU"
  @santa "SAN"

  def part_1(input) do
    orbits = get_orbits(input)

    orbits
    |> Map.keys()
    |> Enum.map(&get_path(orbits, &1, @center_of_mass))
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def part_2(input) do
    orbits = get_orbits(input)

    path_you = get_path(orbits, orbits[@you], @center_of_mass)
    path_santa = get_path(orbits, orbits[@santa], @center_of_mass)

    path_you
    |> get_common_satellites(path_santa)
    |> Enum.map(
      &(get_distance(orbits, orbits[@you], &1) + get_distance(orbits, orbits[@santa], &1))
    )
    |> Enum.min()
  end

  defp get_distance(orbits, from, to), do: orbits |> get_path(from, to) |> Enum.count()

  defp get_path(_orbits, nil, _to), do: []
  defp get_path(_orbits, from, to) when from == to, do: []
  defp get_path(orbits, from, to), do: [from] ++ get_path(orbits, orbits[from], to)

  defp get_common_satellites(satellites_a, satellites_b) do
    satellites_a = MapSet.new(satellites_a)
    satellites_b = MapSet.new(satellites_b)
    satellites_a |> MapSet.intersection(satellites_b) |> MapSet.to_list()
  end

  defp get_orbits(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, orbits ->
      [origin, satellite] = String.split(line, ")")
      Map.put(orbits, satellite, origin)
    end)
  end
end
