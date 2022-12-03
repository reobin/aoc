defmodule AoC.Modules.List do
  @moduledoc """
  Helper functions for working with lists.
  """

  @doc """
  Lists all possible unique pairs of two in a list.
  """
  @spec pairs(list()) :: list(list())
  def pairs(list),
    do: for(x <- list, y <- list, x != y, do: [x, y]) |> Enum.map(&Enum.sort/1) |> Enum.uniq()
end
