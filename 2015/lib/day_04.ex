defmodule AoC.Day04 do
  @moduledoc """
  https://adventofcode.com/2015/day/4
  """

  def part_1(input),
    do: 0..100_000_000 |> Enum.find(fn i -> "#{input}#{i}" |> md5() |> starts_with_zeroes?(5) end)

  def part_2(input),
    do: 0..100_000_000 |> Enum.find(fn i -> "#{input}#{i}" |> md5() |> starts_with_zeroes?(6) end)

  defp md5(value), do: :crypto.hash(:md5, value) |> Base.encode16()

  defp starts_with_zeroes?(value, count), do: String.starts_with?(value, repeat("0", count))

  defp repeat(char, count), do: 0..(count - 1) |> Enum.map(fn _ -> char end) |> Enum.join("")
end
