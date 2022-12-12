defmodule AoC.String do
  @moduledoc """
  Helper functions for working with strings.
  """

  @doc """
  Returns true if the string is all lower cased.
  """
  def lower_case?(str), do: str == String.downcase(str)

  @doc """
  Returns a map stating the frequency of each character in the string.
  """
  def character_frequencies(value),
    do: value |> String.codepoints() |> Enum.frequencies()

  @doc """
  Counts a character in a string.
  """
  def count(str, c), do: str |> character_frequencies() |> Map.get(to_string(c), 0)

  @doc """
  Replaces the value at a range
  """
  def replace_at(value, first..last, replacement) do
    a = String.slice(value, 0..(first - 1))
    b = String.slice(value, (last + 1)..-1)
    a <> replacement <> b
  end
end
