defmodule AoC.Modules.String do
  @moduledoc """
  Helper functions for strings
  """

  @doc """
  Counts a character in a string
  """
  def count(str, c), do: str |> String.graphemes() |> Enum.count(&(&1 == to_string(c)))
end
