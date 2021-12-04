defmodule AoC.Modules.Binary do
  @moduledoc """
  Helper functions for binary values
  """

  import Bitwise

  alias AoC.Modules.Binary

  @doc """
  Converts binary value to decimal
  """
  def to_decimal(binary), do: binary |> Integer.parse(2) |> elem(0)

  @doc """
  Converts decimal value to binary
  """
  def to_binary(binary), do: binary |> Integer.to_string(2)

  @doc """
  Returns max decimal value for a desired binary value length
  """
  def get_max_decimal_value(bit_count), do: (1 <<< bit_count) - 1

  @doc """
  Inverts all bits of a binary value
  """
  def invert(binary) do
    bit_count = String.length(binary)
    decimal = Binary.to_decimal(binary)
    value = Binary.get_max_decimal_value(bit_count) - decimal
    Binary.to_binary(value)
  end
end
