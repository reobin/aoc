defmodule AoC.Modules.Point do
  @moduledoc """
  Module for 2D points
  """

  @doc """
  Returns the Manhattan distance of a point
  """
  def compute_manhattan_distance({x, y}), do: abs(x) + abs(y)

  @doc """
  Returns all points (integer) between two points (excluding the points)
  """
  def get_between(point, point), do: []

  def get_between({x1, y1}, {x2, y2}) when abs(x1 - x2) == 1 or abs(y1 - y2) == 1, do: []

  def get_between({x, y1}, {x, y2}) when y1 > y2,
    do: {x, y2} |> get_between({x, y1}) |> Enum.reverse()

  def get_between({x, y1}, {x, y2}), do: Enum.map((y1 + 1)..(y2 - 1), &{x, &1})

  def get_between({x1, y}, {x2, y}) when x1 > x2,
    do: {x2, y} |> get_between({x1, y}) |> Enum.reverse()

  def get_between({x1, y}, {x2, y}), do: Enum.map((x1 + 1)..(x2 - 1), &{&1, y})

  def get_between({x1, y1}, {x2, y2}) when y1 > y2,
    do: {x2, y2} |> get_between({x1, y1}) |> Enum.reverse()

  def get_between({x1, y1}, {x2, y2}) do
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
end