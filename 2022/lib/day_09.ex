defmodule AoC2022.Day09 do
  @moduledoc """
  https://adventofcode.com/2022/day/9
  """

  alias AoC.Point

  def part_1(input),
    do: input |> parse() |> move_rope({build_rope(2), [build_rope(2)]}) |> count_tail_moves()

  def part_2(input),
    do: input |> parse() |> move_rope({build_rope(10), [build_rope(10)]}) |> count_tail_moves()

  defp build_rope(knot_count), do: 0..(knot_count - 1) |> Enum.map(fn _ -> {0, 0} end)

  defp move_rope([], {_rope, history}), do: history
  defp move_rope([{_d, 0} | moves], history), do: move_rope(moves, history)

  defp move_rope([{direction, distance} | moves], {rope, history}) do
    rope = apply_move(direction, rope)
    move_rope([{direction, distance - 1}] ++ moves, {rope, [rope | history]})
  end

  defp apply_move(:U = d, [{x, y} | tail]), do: ([{x, y - 1}] ++ tail) |> adjust_tail(d)
  defp apply_move(:R = d, [{x, y} | tail]), do: ([{x + 1, y}] ++ tail) |> adjust_tail(d)
  defp apply_move(:D = d, [{x, y} | tail]), do: ([{x, y + 1}] ++ tail) |> adjust_tail(d)
  defp apply_move(:L = d, [{x, y} | tail]), do: ([{x - 1, y}] ++ tail) |> adjust_tail(d)

  defp adjust_tail([], _direction), do: []
  defp adjust_tail([point], _direction), do: [point]

  defp adjust_tail([a, b | tail], direction) do
    b = if Point.distance(a, b) >= 2, do: sneak(b, a), else: b
    [a | adjust_tail([b | tail], direction)]
  end

  defp sneak({ax, ay}, {bx, by}) when ax > bx and ay > by, do: {ax - 1, ay - 1}
  defp sneak({ax, ay}, {bx, by}) when ax > bx and ay < by, do: {ax - 1, ay + 1}
  defp sneak({ax, ay}, {bx, by}) when ax < bx and ay > by, do: {ax + 1, ay - 1}
  defp sneak({ax, ay}, {bx, by}) when ax < bx and ay < by, do: {ax + 1, ay + 1}
  defp sneak({ax, ay}, {bx, _by}) when ax > bx, do: {ax - 1, ay}
  defp sneak({ax, ay}, {bx, _by}) when ax < bx, do: {ax + 1, ay}
  defp sneak({ax, ay}, {_bx, by}) when ay > by, do: {ax, ay - 1}
  defp sneak({ax, ay}, {_bx, by}) when ay < by, do: {ax, ay + 1}

  defp count_tail_moves(history),
    do: history |> Enum.map(&Enum.take(&1, -1)) |> Enum.uniq() |> Enum.count()

  defp parse(input), do: input |> String.split("\n") |> Enum.map(&parse_instruction/1)

  defp parse_instruction(instruction) do
    instruction
    |> String.split(" ")
    |> then(fn [direction, count] -> {String.to_atom(direction), String.to_integer(count)} end)
  end
end
