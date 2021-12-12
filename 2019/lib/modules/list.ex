defmodule AoC.Modules.List do
  @moduledoc """
  List helper functions
  """

  @doc """
  Lists all permutations of elements of a list
  """
  def permutations(enum) when not is_list(enum), do: enum |> Enum.to_list() |> permutations()
  def permutations([]), do: [[]]
  def permutations(l), do: for(e <- l, r <- permutations(l -- [e]), do: [e | r])
end
