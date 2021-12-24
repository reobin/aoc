defmodule AoC.Day23 do
  @moduledoc """
  https://adventofcode.com/2021/day/23
  """

  alias AoC.Modules.Grid
  alias AoC.Modules.Point

  @amber 1
  @bronze 10
  @copper 100
  @desert 1000

  def part_1(_input) do
    # input |> Grid.from_string() |> solve() |> List.flatten() |> Enum.min()
    nil
  end

  def part_2(input) do
    input
    |> unfold()
    |> Grid.from_string()
    |> Grid.print()
    |> solve()
  end

  defp solve(grid), do: solve(grid, %{grid => 0}, 0)

  defp solve(grid, states, energy) do
    Grid.print(grid)

    movable =
      grid
      |> unplaced()
      |> Enum.filter(&(&1 |> possible_moves(grid) |> Enum.count() > 0))
      |> Enum.sort_by(&grid[&1])

    case Enum.count(movable) do
      0 ->
        if complete?(grid), do: energy, else: :infinity

      _ ->
        optimal_move = get_optimal_move(grid, movable)

        if is_nil(optimal_move) do
          movable
          |> Enum.map(fn point ->
            letter = Grid.get(grid, point)

            point
            |> possible_moves(grid)
            |> Enum.filter(fn move ->
              grid = grid |> Grid.set(point, ".") |> Grid.set(move, letter)
              states |> Map.get(grid) |> is_nil()
            end)
            |> Enum.map(fn move -> make_move(grid, states, point, move, energy) end)
            |> Enum.min()
          end)
          |> Enum.min()
        else
          {from, to} = optimal_move
          make_move(grid, states, from, to, energy)
        end
    end
  end

  defp get_optimal_move(grid, movable, checked \\ []) do
    movable
    |> Enum.filter(&(&1 not in checked))
    |> Enum.find_value(fn point ->
      goal = get_goal(point, grid)
      points = accessible_points(point, grid)

      if goal in points do
        {point, goal}
      else
        if grid[goal] in ["A", "B", "C", "D"],
          do: get_optimal_move(grid, [goal], checked ++ [point]),
          else: nil
      end
    end)
  end

  defp get_goal(point, grid), do: get_goal(point, grid, grid[point])

  defp get_goal(_point, grid, letter),
    do: letter |> room_points() |> Enum.reverse() |> Enum.find(&(grid[&1] != letter))

  defp make_move(grid, states, from, to, energy) do
    letter = Grid.get(grid, from)

    grid = grid |> Grid.set(from, ".") |> Grid.set(to, letter)

    energy = energy + compute_energy(from, to, letter)

    states = Map.put(states, grid, energy)

    solve(grid, states, energy)
  end

  defp possible_moves({_, 1} = point, grid) do
    grid
    |> Grid.get(point)
    |> room_points()
    |> Enum.filter(&(&1 in accessible_points(point, grid)))
    |> Enum.filter(&(not floating?(&1, grid, grid[point])))
  end

  defp possible_moves(point, grid) do
    grid
    |> Grid.get_points()
    |> Enum.filter(&(elem(&1, 1) == 1 and elem(&1, 0) not in [3, 5, 7, 9]))
    |> Enum.filter(&(&1 in accessible_points(point, grid)))
  end

  defp floating?({_, 1}, _grid, _letter), do: false
  defp floating?({_, 5}, _grid, _letter), do: false

  defp floating?({x, y}, grid, letter) when y >= 2,
    do: (y + 1)..5 |> Enum.map(&{x, &1}) |> Enum.any?(&(grid[&1] != letter))

  defp floating?(_point, _grid, _letter), do: false

  defp accessible_points(point, grid) do
    neighbors = point |> Point.get_neighbors() |> Enum.filter(&(Grid.get(grid, &1, "#") == "."))
    grid = Enum.reduce(neighbors, grid, &Grid.set(&2, &1, "#"))
    more = Enum.flat_map(neighbors, &accessible_points(&1, grid))
    neighbors ++ more
  end

  defp unplaced(grid) do
    grid
    |> Grid.get_points()
    |> Enum.filter(&(Grid.get(grid, &1) in ["A", "B", "C", "D"]))
    |> Enum.filter(&(not placed?(&1, grid)))
  end

  defp placed?(point, grid), do: placed?(point, grid, grid[point])

  defp placed?({3, y}, _grid, "A") when y < 2, do: false

  defp placed?({3, y}, grid, "A") do
    y..5 |> Enum.all?(&(grid[{3, &1}] == "A"))
  end

  defp placed?(_point, _grid, "A"), do: false

  defp placed?({5, y}, _grid, "B") when y < 2, do: false

  defp placed?({5, y}, grid, "B"),
    do: y..5 |> Enum.all?(&(grid[{5, &1}] == "B"))

  defp placed?(_point, _grid, "B"), do: false

  defp placed?({7, y}, _grid, "C") when y < 2, do: false

  defp placed?({7, y}, grid, "C"),
    do: y..5 |> Enum.all?(&(grid[{7, &1}] == "C"))

  defp placed?(_point, _grid, "C"), do: false

  defp placed?({9, y}, _grid, "D") when y < 2, do: false

  defp placed?({9, y}, grid, "D"),
    do: y..5 |> Enum.all?(&(grid[{9, &1}] == "D"))

  defp placed?(_point, _grid, "D"), do: false

  defp complete?(grid) do
    "A" |> room_points() |> Enum.all?(&(Grid.get(grid, &1) == "A")) and
      "B" |> room_points() |> Enum.all?(&(Grid.get(grid, &1) == "B")) and
      "C" |> room_points() |> Enum.all?(&(Grid.get(grid, &1) == "C")) and
      "D" |> room_points() |> Enum.all?(&(Grid.get(grid, &1) == "D"))
  end

  defp room_points(letter, from \\ 2)

  defp room_points("A", from), do: from..5 |> Enum.map(&{3, &1})
  defp room_points("B", from), do: from..5 |> Enum.map(&{5, &1})
  defp room_points("C", from), do: from..5 |> Enum.map(&{7, &1})
  defp room_points("D", from), do: from..5 |> Enum.map(&{9, &1})
  defp room_points(_letter, _from), do: []

  defp compute_energy(from, to, "A"), do: compute_energy(from, to) * @amber
  defp compute_energy(from, to, "B"), do: compute_energy(from, to) * @bronze
  defp compute_energy(from, to, "C"), do: compute_energy(from, to) * @copper
  defp compute_energy(from, to, "D"), do: compute_energy(from, to) * @desert
  defp compute_energy({x1, y1}, {x2, y2}) when y1 == 1 or y2 == 1, do: abs(x1 - x2) + abs(y1 - y2)

  defp compute_energy({x1, y1}, {x2, y2}) do
    stop = {x2, 1}
    compute_energy({x1, y1}, stop) + compute_energy(stop, {x2, y2})
  end

  defp unfold(input) do
    lines = input |> String.split("\n", trim: true)

    top = Enum.slice(lines, 0..2)
    center = ["  #D#C#B#A#  ", "  #D#B#A#C#  "]
    bottom = Enum.slice(lines, 3..-1)

    Enum.join(top ++ center ++ bottom, "\n")
  end
end
