defmodule AoC.Modules.Point do
  @moduledoc """
  Module for a 2D point
  """

  @doc """
  Returns all points between 2 points
  """
  def get_line(point_1, point_2), do: get_line(point_1, point_2, [])
  def get_line({x1, y1}, {x2, y2}, points) when x1 == x2 and y1 == y2, do: points ++ [{x2, y2}]

  def get_line({x1, y1}, {x2, y2}, points) do
    get_multiplier = fn a, b -> if a == b, do: 0, else: if(a > b, do: -1, else: 1) end

    multiplier_x = get_multiplier.(x1, x2)
    multiplier_y = get_multiplier.(y1, y2)

    next = {x1 + 1 * multiplier_x, y1 + 1 * multiplier_y}

    points ++ get_line(next, {x2, y2}, [{x1, y1}])
  end

  @doc """
  Returns all points adjacent to a point
  """
  def get_neighbors(point), do: get_neighbors(point, 4)
  def get_neighbors({x, y}, 4), do: [{x, y - 1}, {x + 1, y}, {x, y + 1}, {x - 1, y}]

  def get_neighbors({x, y}, 8),
    do: [
      {x, y - 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1},
      {x, y + 1},
      {x - 1, y + 1},
      {x - 1, y},
      {x - 1, y - 1}
    ]
end
