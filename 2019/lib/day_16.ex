defmodule AoC2019.Day16 do
  @moduledoc """
  https://adventofcode.com/2019/day/16
  """

  @base_pattern [0, 1, 0, -1]

  def part_1(input, phase_count \\ 100) do
    input
    |> parse()
    |> Stream.iterate(&fft/1)
    |> Enum.at(phase_count)
    |> Enum.take(8)
    |> Enum.join("")
  end

  def part_2(input) do
    signal = input |> parse() |> List.duplicate(10_000) |> List.flatten()
    target_index = signal |> Enum.take(7) |> Enum.join() |> String.to_integer()

    signal
    |> Enum.drop(target_index)
    |> Stream.iterate(&fft_phase/1)
    |> Enum.at(100)
    |> Enum.take(8)
    |> Enum.join("")
  end

  defp fft_phase(signal) do
    List.foldr(signal, [], fn
      element, [] -> [element]
      element, [previous | _] = rest -> [rem(element + previous, 10) | rest]
    end)
  end

  defp fft(signal) do
    1..length(signal)
    |> Enum.map(fn i ->
      pattern = repeat(@base_pattern, i)

      signal
      |> Enum.with_index()
      |> Enum.map(&multiply(&1, pattern))
      |> Enum.sum()
      |> abs()
      |> rem(10)
    end)
  end

  defp multiply({a, i}, pattern) when i > length(pattern) - 1,
    do: multiply({a, rem(i, length(pattern))}, pattern)

  defp multiply({a, i}, pattern), do: a * (Enum.at(pattern, i + 1) || Enum.at(pattern, 0))

  defp repeat(pattern, n), do: Enum.flat_map(pattern, &List.duplicate(&1, n))

  defp parse(input),
    do: input |> String.trim() |> String.codepoints() |> Enum.map(&String.to_integer/1)
end
