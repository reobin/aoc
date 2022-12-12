defmodule AoC.Binary do
  @moduledoc """
  Helper functions for working with binary values.
  """

  import Bitwise

  alias AoC.Binary

  @type bin() :: String.t()

  @doc """
  Converts binary value to decimal.
  """
  @spec to_decimal(bin()) :: integer()
  def to_decimal(binary), do: binary |> Integer.parse(2) |> elem(0)

  @doc """
  Converts decimal value to binary.
  """
  @spec to_decimal(integer()) :: bin()
  def from_decimal(binary), do: binary |> Integer.to_string(2)

  @doc """
  Returns max decimal value for a desired binary value length.
  """
  @spec to_decimal(integer()) :: integer()
  def get_max_decimal_value(bit_count), do: (1 <<< bit_count) - 1

  @doc """
  Inverts all bits of a binary value
  """
  @spec invert(bin()) :: bin()
  def invert(binary) do
    bit_count = String.length(binary)
    decimal = Binary.to_decimal(binary)
    result = Binary.get_max_decimal_value(bit_count) - decimal
    Binary.from_decimal(result)
  end
end
