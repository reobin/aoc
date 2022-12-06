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

  @doc """
  Returns true if the list is only composed of unique elements.
  """
  @spec unique?(list()) :: boolean()
  def unique?(list), do: list |> MapSet.new() |> MapSet.size() == Enum.count(list)
end
