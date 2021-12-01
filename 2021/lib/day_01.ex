defmodule AoC.Day01 do
  def part_1(input) do
    input
    |> get_measurements()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(&did_increase?/1)
  end

  def part_2(input) do
    input
    |> get_measurements()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(&did_increase?/1)
  end

  defp get_measurements(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  defp did_increase?([a, b]), do: b > a
end
