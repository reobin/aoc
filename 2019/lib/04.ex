defmodule AoC.Day04 do
  def part_1(input),
    do: input |> get_range() |> Enum.filter(&is_valid?/1) |> Enum.count()

  def part_2(input),
    do: input |> get_range() |> Enum.filter(&is_valid_strict?/1) |> Enum.count()

  defp get_range(input) do
    [_match, min, max] = Regex.run(~r/(\d{6})-(\d{6})/, input)
    String.to_integer(min)..String.to_integer(max) |> Enum.to_list()
  end

  defp is_valid?(password) do
    digits = password |> Integer.digits()
    increments?(digits) and has_double?(digits)
  end

  defp is_valid_strict?(password) do
    digits = password |> Integer.digits()
    increments?(digits) and has_strict_double?(digits)
  end

  defp increments?([]), do: true
  defp increments?([d1 | [d2 | _]]) when d1 > d2, do: false
  defp increments?([_ | digits]), do: increments?(digits)

  defp has_double?([]), do: false
  defp has_double?([d1 | [d2 | _]]) when d1 == d2, do: true
  defp has_double?([_ | digits]), do: has_double?(digits)

  defp has_strict_double?([]), do: false
  defp has_strict_double?([_d]), do: false
  defp has_strict_double?([d, d, d, d, d | _digits]), do: false
  defp has_strict_double?([d, d, d, d | digits]), do: has_strict_double?(digits)
  defp has_strict_double?([d, d, d | digits]), do: has_strict_double?(digits)
  defp has_strict_double?([d, d | _digits]), do: true
  defp has_strict_double?([_d | digits]), do: has_strict_double?(digits)
end
