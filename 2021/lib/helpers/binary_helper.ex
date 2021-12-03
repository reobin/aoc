defmodule AoC.Helpers.BinaryHelper do
  @moduledoc """
  Helper functions for binary values
  """

  import Bitwise

  @doc """
  Converts binary value to decimal
  """
  def to_decimal(binary), do: binary |> Integer.parse(2) |> elem(0)

  @doc """
  Returns max decimal value for a desired binary value length
  """
  def get_max_decimal_value(bit_count), do: (1 <<< bit_count) - 1
end
