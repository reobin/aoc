defmodule AoC.Day03 do
  alias AoC.Modules.Binary

  def part_1(input) do
    gamma =
      input
      |> get_numbers()
      |> invert_list_axis()
      |> Enum.map(&Enum.frequencies/1)
      |> Enum.map(&Enum.max_by(&1, fn {_value, frequency} -> frequency end))
      |> Enum.map(&elem(&1, 0))
      |> Enum.join("")

    bit_count = String.length(gamma)
    gamma = Binary.to_decimal(gamma)
    epsilon = Binary.get_max_decimal_value(bit_count) - gamma

    gamma * epsilon
  end

  def part_2(input) do
    numbers = input |> get_numbers()
    get_rating(numbers, name: :o2) * get_rating(numbers, name: :co2)
  end

  defp get_rating(numbers, options), do: get_rating(numbers, 0, options)

  defp get_rating([number], _index, _options),
    do: number |> Enum.join("") |> Binary.to_decimal()

  defp get_rating(numbers, index, options) do
    frequencies =
      numbers
      |> invert_list_axis()
      |> Enum.at(index)
      |> Enum.frequencies()

    {next_bit, _frequency} = frequencies |> sort_frequencies(options)

    remaining_numbers =
      numbers |> Enum.filter(fn number -> Enum.at(number, index) == next_bit end)

    get_rating(remaining_numbers, index + 1, options)
  end

  defp sort_frequencies(frequencies, name: :o2) do
    frequencies
    |> Enum.sort_by(fn {value, _frequency} -> value end, &>/2)
    |> Enum.max_by(fn {_value, frequency} -> frequency end)
  end

  defp sort_frequencies(frequencies, name: :co2) do
    frequencies
    |> Enum.sort_by(fn {value, _frequency} -> value end)
    |> Enum.min_by(fn {_value, frequency} -> frequency end)
  end

  defp invert_list_axis(list) do
    list
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp get_numbers(input) do
    input
    |> String.split("\n")
    |> Enum.reduce([], fn line, numbers ->
      numbers ++ [line |> String.split("", trim: true)]
    end)
  end
end
