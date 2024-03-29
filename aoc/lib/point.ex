defmodule AoC.Point do
  @moduledoc """
  Module for 2D points.
  """

  @type point :: {integer(), integer()}
  @type point_3d :: {integer(), integer(), integer()}

  @doc """
  Returns the Manhattan distance of a point.
  """
  @spec manhattan_distance(point()) :: integer()
  def manhattan_distance(point), do: manhattan_distance(point, {0, 0})
  @spec manhattan_distance(point(), point()) :: integer()
  def manhattan_distance({ax, ay}, {bx, by}), do: abs(ax - bx) + abs(ay - by)

  @doc """
  Returns all points (integer) between two points (excluding the points).
  """
  @spec between(point(), point()) :: [point()]
  def between(from, to, inclusive?: true), do: [from] ++ between(from, to) ++ [to]
  def between(point, point), do: []

  def between({x1, y1}, {x2, y2}) when abs(x1 - x2) == 1 or abs(y1 - y2) == 1, do: []

  def between({x, y1}, {x, y2}) when y1 > y2,
    do: {x, y2} |> between({x, y1}) |> Enum.reverse()

  def between({x, y1}, {x, y2}), do: Enum.map((y1 + 1)..(y2 - 1), &{x, &1})

  def between({x1, y}, {x2, y}) when x1 > x2,
    do: {x2, y} |> between({x1, y}) |> Enum.reverse()

  def between({x1, y}, {x2, y}), do: Enum.map((x1 + 1)..(x2 - 1), &{&1, y})

  def between({x1, y1}, {x2, y2}) when y1 > y2,
    do: {x2, y2} |> between({x1, y1}) |> Enum.reverse()

  def between({x1, y1}, {x2, y2}) do
    diff_x = x2 - x1
    diff_y = y2 - y1

    slope = diff_x / diff_y

    steps_to_integer = 1..1000 |> Enum.find(1, &(&1 * slope == round(&1 * slope)))

    max_steps = Enum.max([div(diff_y, steps_to_integer) - 1, 1])

    1..max_steps
    |> Enum.reduce({{x1, y1}, []}, fn _, {{x, y}, points} ->
      x = round(x + slope * steps_to_integer)
      y = y + steps_to_integer

      {{x, y}, points ++ [{x, y}]}
    end)
    |> elem(1)
    |> Enum.filter(&(&1 not in [{x1, y1}, {x2, y2}]))
  end

  @doc """
  Returns the distance of two points.
  """
  @spec distance(point(), point()) :: integer()
  def distance(point, point), do: 0
  def distance({ax, ay}, {bx, by}), do: :math.sqrt(:math.pow(ax - bx, 2) + :math.pow(ay - by, 2))

  @doc """
  Returns all points adjacent to a point.
  """
  @spec neighbors(point()) :: [point()]
  def neighbors({x, y}), do: neighbors({x, y}, 4)

  @spec neighbors(point(), integer()) :: [point()]
  def neighbors({x, y}, 4), do: [{x, y - 1}, {x + 1, y}, {x, y + 1}, {x - 1, y}]

  def neighbors({x, y}, 8),
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

  @spec neighbors(point_3d()) :: [point_3d()]
  def neighbors({x, y, z}), do: neighbors({x, y, z}, 6)

  @spec neighbors(point_3d(), integer()) :: [point_3d()]
  def neighbors({x, y, z}, 6),
    do: [
      {x + 1, y, z},
      {x - 1, y, z},
      {x, y + 1, z},
      {x, y - 1, z},
      {x, y, z + 1},
      {x, y, z - 1}
    ]

  @doc """
  Returns true if the two points share an axis.
  """
  @spec share_axis?(point(), point()) :: boolean()
  def share_axis?({x1, y1}, {x2, y2}), do: x1 == x2 or y1 == y2
end
