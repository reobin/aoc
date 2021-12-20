defmodule AoC.Day19 do
  @moduledoc """
  https://adventofcode.com/2021/day/19
  """

  def part_1(input),
    do: input |> get_scanner_data() |> Enum.flat_map(&elem(&1, 2)) |> Enum.uniq() |> Enum.count()

  def part_2(input) do
    scanner_points = input |> get_scanner_data() |> Enum.map(&elem(&1, 1))

    for(scanner_a <- scanner_points, scanner_b <- scanner_points, do: {scanner_a, scanner_b})
    |> Enum.map(fn {{x1, y1, z1}, {x2, y2, z2}} -> x1 - x2 + (y1 - y2) + (z1 - z2) end)
    |> Enum.max()
  end

  defp get_scanner_data(input) do
    [{id, beacons} | scanner_data] = get_data(input)

    0..1000
    |> Enum.reduce_while(
      {[{id, {0, 0, 0}, beacons}], scanner_data},
      fn _, {scanners, scanner_data} ->
        {id, _origin, _beacons} =
          pair = scanners |> Enum.reverse() |> Enum.find_value(&find_pair(&1, scanner_data))

        scanners = [pair] ++ scanners
        scanner_data = Enum.filter(scanner_data, &(elem(&1, 0) != id))

        if Enum.count(scanner_data) == 0 do
          {:halt, scanners}
        else
          {:cont, {scanners, scanner_data}}
        end
      end
    )
  end

  defp find_pair(scanner, scanner_data) do
    Enum.find_value(scanner_data, fn {lookup_id, lookup_beacons} ->
      Enum.find_value(0..23, fn rotation_index ->
        lookup_beacons = Enum.map(lookup_beacons, &Enum.at(get_rotations(&1), rotation_index))
        get_matching_arrangement(scanner, {lookup_id, lookup_beacons})
      end)
    end)
  end

  defp get_matching_arrangement({_id_a, _origin_a, beacons_a}, {id_b, beacons_b}) do
    for(ref_a <- beacons_a, ref_b <- beacons_b, do: {ref_a, ref_b})
    |> Enum.find_value(fn {ref_a, ref_b} ->
      points_a = beacons_a |> List.delete(ref_a) |> get_points_relative_to(ref_a)
      points_b = beacons_b |> List.delete(ref_b) |> get_points_relative_to(ref_b)

      if count_common_beacons(points_a, points_b) >= 11 do
        {x1, y1, z1} = ref_a
        {x2, y2, z2} = ref_b

        {x, y, z} = origin_b = {x1 - x2, y1 - y2, z1 - z2}

        relative_points = Enum.map(beacons_b, fn {x2, y2, z2} -> {x2 + x, y2 + y, z2 + z} end)

        {id_b, origin_b, relative_points}
      end
    end)
  end

  defp get_points_relative_to(points, {x1, y1, z1}),
    do: points |> Enum.map(fn {x2, y2, z2} -> {x2 - x1, y2 - y1, z2 - z1} end)

  defp count_common_beacons(a, b),
    do: a |> MapSet.new() |> MapSet.intersection(MapSet.new(b)) |> MapSet.size()

  defp get_rotations({x, y, z}) do
    [
      {-x, -y, z},
      {-y, x, z},
      {x, y, z},
      {y, -x, z},
      {x, -y, -z},
      {-y, -x, -z},
      {-x, y, -z},
      {y, x, -z},
      {y, z, x},
      {z, -y, x},
      {-y, -z, x},
      {-z, y, x},
      {-z, -y, -x},
      {-y, z, -x},
      {z, y, -x},
      {y, -z, -x},
      {-z, -x, y},
      {-x, z, y},
      {z, x, y},
      {x, -z, y},
      {z, -x, -y},
      {-x, -z, -y},
      {-z, x, -y},
      {x, z, -y}
    ]
  end

  defp get_data(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn block ->
      [scanner | beacons] = String.split(block, "\n", trim: true)

      [scanner] = Regex.run(~r/\d+/, scanner)

      beacons =
        Enum.map(beacons, fn line ->
          line |> String.split(",") |> Enum.map(&String.to_integer/1) |> then(&List.to_tuple/1)
        end)

      {scanner, beacons}
    end)
  end
end
