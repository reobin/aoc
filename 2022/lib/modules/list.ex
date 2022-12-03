defmodule AoC.Modules.List do
  @moduledoc """
  Helper functions for working with lists.
  """

  @doc """
  Returns the list of common elements between given lists.
  """
  @spec intersection(list()) :: list()
  def intersection(list),
    do: list |> Enum.map(&MapSet.new/1) |> Enum.reduce(&MapSet.intersection/2) |> MapSet.to_list()

  @doc """
  Splits a list into equal parts.
  """
  @spec split(list(), integer()) :: list()
  def split(list, parts), do: list |> Enum.chunk_every(trunc(Enum.count(list) / parts))
end
