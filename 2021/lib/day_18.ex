defmodule AoC2021.Day18 do
  @moduledoc """
  https://adventofcode.com/2021/day/18
  """

  alias AoC.String, as: StringHelper

  def part_1(input) do
    [first | numbers] = get_numbers(input)
    numbers |> Enum.reduce(first, &add(&2, &1)) |> magnitude()
  end

  def part_2(input) do
    numbers = input |> get_numbers()

    numbers
    |> Enum.with_index()
    |> Enum.flat_map(fn {a, index} -> sums(a, numbers |> List.delete_at(index)) end)
    |> Enum.max()
  end

  defp sums(n, numbers),
    do: numbers |> Enum.flat_map(&[n |> add(&1) |> magnitude(), &1 |> add(n) |> magnitude()])

  defp add(a, b), do: reduce("[#{a},#{b}]")

  defp reduce(number) do
    exploded = explode(number)

    if number != exploded do
      reduce(exploded)
    else
      split = split(number)
      if number != split, do: reduce(split), else: number
    end
  end

  defp explode(number) do
    {match, pair} = get_pair_at_depth(number, 4)

    if match == :error do
      number
    else
      left = Regex.run(~r/(\d+)[^\d]*$/, pair.lead, return: :index)

      lead =
        if is_nil(left) do
          pair.lead
        else
          [_, {index, length}] = left
          value = pair.lead |> String.slice(index..(index + length - 1)) |> String.to_integer()
          replacement = Integer.to_string(value + pair.a)
          StringHelper.replace_at(pair.lead, index..(index + length - 1), replacement)
        end

      trail =
        String.replace(
          pair.trail,
          ~r/\d+/,
          fn n -> n |> String.to_integer() |> then(&(&1 + pair.b)) |> Integer.to_string() end,
          global: false
        )

      lead <> "0" <> trail
    end
  end

  defp get_pair_at_depth(number, depth) do
    match =
      ~r/\d+,\d+/
      |> Regex.scan(number, return: :index)
      |> List.flatten()
      |> Enum.find(fn {pair_index, _} ->
        ups = number |> String.slice(0..(pair_index - 2)) |> StringHelper.count("[")
        downs = number |> String.slice(0..(pair_index - 2)) |> StringHelper.count("]")
        ups - downs == depth
      end)

    if is_nil(match) do
      {:error, nil}
    else
      {index, length} = match

      [a, b] =
        number
        |> String.slice(index..(index + length - 1))
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)

      lead = String.slice(number, 0..(index - 2))
      trail = String.slice(number, (index + length + 1)..-1)

      {:ok, %{lead: lead, a: a, b: b, trail: trail}}
    end
  end

  defp split(number) do
    match = Regex.run(~r/\d{2,}/, number, return: :index)

    if is_nil(match) do
      number
    else
      [{index, length}] = match
      value = String.slice(number, index..(index + length - 1)) |> String.to_integer()
      replacement = "[#{floor(value / 2)},#{ceil(value / 2)}]"
      StringHelper.replace_at(number, index..(index + length - 1), replacement)
    end
  end

  defp magnitude(n) when is_integer(n), do: n
  defp magnitude([a, b]), do: 3 * magnitude(a) + 2 * magnitude(b)
  defp magnitude(str), do: str |> Code.string_to_quoted!() |> magnitude()

  defp get_numbers(input), do: input |> String.split("\n", trim: true)
end
