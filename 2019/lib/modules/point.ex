defmodule AoC.Modules.Point do
  @moduledoc """
  Module for 2D points
  """

  @doc """
  Returns the Manhattan distance of a point
  """
  def compute_manhattan_distance({x, y}), do: abs(x) + abs(y)
end
