defmodule AoC.Day16 do
  @moduledoc """
  https://adventofcode.com/2021/day/16
  """

  alias AoC.Modules.Binary

  @sum 0
  @product 1
  @minimum 2
  @maximum 3
  @literal 4
  @greater_than 5
  @less_than 6
  @equal 7

  @version_offset 3
  @type_offset 3

  @fifteen "0"
  @eleven "1"

  @version_offset 3
  @type_offset 3
  @length_id_offset 1
  @total_length_offset 15
  @packet_count_offset 11

  def part_1(input), do: input |> get_transmission() |> read_packet() |> get_version_sum()
  def part_2(input), do: input |> get_transmission() |> read_packet() |> compute()

  defp compute(%{type: @sum, value: v}), do: v |> Enum.map(&compute/1) |> Enum.sum()
  defp compute(%{type: @product, value: v}), do: v |> Enum.map(&compute/1) |> Enum.product()
  defp compute(%{type: @minimum, value: v}), do: v |> Enum.map(&compute/1) |> Enum.min()
  defp compute(%{type: @maximum, value: v}), do: v |> Enum.map(&compute/1) |> Enum.max()
  defp compute(%{type: @literal, value: v}), do: v
  defp compute(%{type: @greater_than, value: v}), do: compare(v, &>/2)
  defp compute(%{type: @less_than, value: v}), do: compare(v, &</2)
  defp compute(%{type: @equal, value: v}), do: compare(v, &==/2)

  defp compare([first, second], operator), do: if(operator.(first, second), do: 1, else: 0)

  defp read_packet(packet) do
    version = get_version(packet)
    type = get_type(packet)

    packet = String.slice(packet, (@version_offset + @type_offset)..-1)

    packet
    |> read_value(type)
    |> then(fn {value, bit_count, next} ->
      %{
        version: version,
        type: type,
        length_id: if(type != @literal, do: String.at(packet, 0), else: nil),
        value: value,
        bit_count: bit_count,
        next: next
      }
    end)
  end

  defp read_value(packet, @literal) do
    {value, bit_count} =
      0..100
      |> Enum.map(&(&1 * 5))
      |> Enum.reduce_while({"", 0}, fn start, {value, bit_count} ->
        first_bit = String.at(packet, start)
        action = if first_bit == "1", do: :cont, else: :halt

        bit_group = String.slice(packet, (start + 1)..(start + 4))
        {action, {value <> bit_group, bit_count + 5}}
      end)

    value = Binary.to_decimal(value)
    next = String.slice(packet, bit_count..-1)
    bit_count = bit_count + @version_offset + @type_offset

    {value, bit_count, next}
  end

  defp read_value(packet, _type) do
    length_id = String.at(packet, 0)
    packet = String.slice(packet, @length_id_offset..-1)
    read_subpackets(packet, length_id)
  end

  defp read_subpackets(packet, @fifteen) do
    length = packet |> String.slice(0..(@total_length_offset - 1)) |> Binary.to_decimal()

    packet = String.slice(packet, @total_length_offset..-1)

    0..1000
    |> Enum.reduce_while({[], 0, packet}, fn _, {values, bit_count, packet} ->
      value = read_packet(packet)
      value = Map.put(value, :bit_count, get_total_bit_count(value))

      bit_count = bit_count + value.bit_count

      action = if bit_count == length, do: :halt, else: :cont

      {action, {values ++ [value], bit_count, value.next}}
    end)
  end

  defp read_subpackets(packet, @eleven) do
    packet_count = packet |> String.slice(0..(@packet_count_offset - 1)) |> Binary.to_decimal()

    packet = String.slice(packet, @packet_count_offset..-1)

    1..packet_count
    |> Enum.reduce({[], 0, packet}, fn _, {values, bit_count, packet} ->
      value = read_packet(packet)
      value = Map.put(value, :bit_count, get_total_bit_count(value))

      bit_count = bit_count + value.bit_count

      {values ++ [value], bit_count, value.next}
    end)
  end

  defp get_transmission(input) do
    input
    |> String.split("", trim: true)
    |> Enum.map(&Integer.parse(&1, 16))
    |> Enum.map(&Binary.from_decimal(elem(&1, 0)))
    |> Enum.map(&String.pad_leading(&1, 4, "0"))
    |> Enum.join("")
  end

  defp get_version_sum(%{value: value} = packet) when is_integer(value), do: packet.version

  defp get_version_sum(packet),
    do: packet.value |> Enum.map(&get_version_sum/1) |> Enum.sum() |> then(&(&1 + packet.version))

  defp get_total_bit_count(%{length_id: @fifteen, value: value} = packet)
       when is_integer(value) do
    packet.bit_count + @total_length_offset + @length_id_offset + @version_offset + @type_offset
  end

  defp get_total_bit_count(%{length_id: @eleven, value: value} = packet) when is_integer(value) do
    packet.bit_count + @packet_count_offset + @length_id_offset + @version_offset + @type_offset
  end

  defp get_total_bit_count(%{value: value, bit_count: bit_count}) when is_integer(value),
    do: bit_count

  defp get_total_bit_count(%{length_id: @fifteen, value: value}) do
    value
    |> Enum.map(&get_total_bit_count/1)
    |> Enum.sum()
    |> then(&(&1 + @total_length_offset + @length_id_offset + @version_offset + @type_offset))
  end

  defp get_total_bit_count(%{length_id: @eleven} = packet) do
    packet.value
    |> Enum.map(&get_total_bit_count/1)
    |> Enum.sum()
    |> then(&(&1 + @packet_count_offset + @length_id_offset + @version_offset + @type_offset))
  end

  defp get_version(packet),
    do: packet |> String.slice(0..(@version_offset - 1)) |> Binary.to_decimal()

  defp get_type(packet) do
    packet
    |> String.slice(@version_offset..(@version_offset + @type_offset - 1))
    |> Binary.to_decimal()
  end
end
