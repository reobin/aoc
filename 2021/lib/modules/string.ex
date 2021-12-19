defmodule AoC.Modules.String do
  @moduledoc """
  Helper functions for strings
  """

  @doc """
  Counts a character in a string
  """
  def count(str, c), do: str |> String.graphemes() |> Enum.count(&(&1 == to_string(c)))

  @doc """
  Returns true if the string is all lower cased
  """
  def is_lower_case?(str), do: str == String.downcase(str)

  @doc """
  Returns a map stating the frequency of each character in the string
  """
  def get_character_frequencies(value),
    do: value |> String.split("", trim: true) |> Enum.frequencies()

  @doc """
  Replaces the value at a range
  """
  def replace_at(value, first..last, replacement) do
    a = String.slice(value, 0..first)
    b = String.slice(value, last..-1)
    a <> replacement <> b
  end
end
