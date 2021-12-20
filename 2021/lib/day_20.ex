defmodule AoC.Day20 do
  @moduledoc """
  https://adventofcode.com/2021/day/20
  """

  alias AoC.Modules.Grid
  alias AoC.Modules.Binary

  def part_1(input), do: run(input, 2)
  def part_2(input), do: run(input, 50)

  defp run(input, iteration_count) do
    {algorithm, input_image} = get_data(input)

    1..iteration_count
    |> Enum.reduce(input_image, &run_algorithm(&2, algorithm, &1))
    |> Grid.get_values()
    |> Enum.count(&(&1 == "#"))
  end

  defp run_algorithm(input_image, algorithm, iteration) do
    default_value = if(rem(iteration, 2) == 0, do: "#", else: ".")
    default_value = if String.at(algorithm, 0) == "#", do: default_value, else: "."

    input_image
    |> Grid.add_layer(default_value)
    |> Grid.get_points()
    |> Enum.reduce(%{}, fn point, output ->
      index = get_square_value(input_image, point, default_value)
      Grid.set(output, point, String.at(algorithm, index))
    end)
  end

  defp get_square_value(grid, {x, y}, default_value) do
    [{-1, -1}, {0, -1}, {1, -1}, {-1, 0}, {0, 0}, {1, 0}, {-1, 1}, {0, 1}, {1, 1}]
    |> Enum.map(fn {dx, dy} -> Grid.get(grid, {x + dx, y + dy}, default_value) end)
    |> Enum.map(&if &1 == ".", do: "0", else: "1")
    |> Enum.join("")
    |> Binary.to_decimal()
  end

  defp get_data(input) do
    [algorithm, input_image] = String.split(input, "\n\n", trim: true)
    {algorithm, Grid.from_string(input_image)}
  end
end
