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

    epsilon = gamma |> Binary.invert()

    Binary.to_decimal(gamma) * Binary.to_decimal(epsilon)
  end

  def part_2(input) do
    numbers = input |> get_numbers()
    get_rating(numbers, :o2) * get_rating(numbers, :co2)
  end

  defp get_rating(numbers, type), do: get_rating(numbers, 0, type)

  defp get_rating([number], _index, _type),
    do: number |> Enum.join("") |> Binary.to_decimal()

  defp get_rating(numbers, index, type) do
    frequencies =
      numbers
      |> invert_list_axis()
      |> Enum.at(index)
      |> Enum.frequencies()

    {next_bit, _frequency} = frequencies |> sort_frequencies(type)

    remaining_numbers =
      numbers |> Enum.filter(fn number -> Enum.at(number, index) == next_bit end)

    get_rating(remaining_numbers, index + 1, type)
  end

  defp sort_frequencies(frequencies, :o2) do
    frequencies
    |> Enum.sort_by(fn {value, _frequency} -> value end, &>/2)
    |> Enum.max_by(fn {_value, frequency} -> frequency end)
  end

  defp sort_frequencies(frequencies, :co2) do
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
