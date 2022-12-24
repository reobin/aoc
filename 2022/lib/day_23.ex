defmodule AoC2022.Day23 do
  @moduledoc """
  https://adventofcode.com/2022/day/23
  """

  alias AoC.Grid

  def part_1(input) do
    input
    |> Grid.from_string()
    |> run(10)
    |> build_rectangle()
    |> Grid.values()
    |> Enum.count(&(&1 == "."))
  end

  def part_2(input), do: input |> Grid.from_string() |> run()

  defp run(map), do: run(map, 1, :infinity)
  defp run(map, max_round), do: run(map, 1, max_round)
  defp run(map, round, max_round) when round == max_round + 1, do: map

  defp run(map, round, max_round) do
    new_map = map |> consider(round) |> move(map)

    if elves(map) == elves(new_map) and max_round == :infinity,
      do: round,
      else: run(new_map, round + 1, max_round)
  end

  defp build_rectangle(map) do
    min_x = map |> elves() |> Enum.map(&elem(&1, 0)) |> Enum.min()
    max_x = map |> elves() |> Enum.map(&elem(&1, 0)) |> Enum.max()
    min_y = map |> elves() |> Enum.map(&elem(&1, 1)) |> Enum.min()
    max_y = map |> elves() |> Enum.map(&elem(&1, 1)) |> Enum.max()

    for(x <- min_x..max_x, y <- min_y..max_y, do: {x, y})
    |> Enum.reduce(Grid.new(), fn point, acc -> Grid.set(acc, point, Grid.get(map, point)) end)
    |> Grid.to_string(replace_nil_with: ".")
    |> Grid.from_string()
  end

  defp consider(map, round),
    do: map |> elves() |> Enum.map(fn elf -> {elf, suggest(map, elf, round)} end)

  defp move(moves, map) do
    moves
    |> Enum.filter(&unique_move?(&1, moves))
    |> Enum.reduce(map, fn {elf, move}, map ->
      map |> Grid.set(elf, ".") |> Grid.set(move, "#")
    end)
  end

  defp unique_move?({elf_a, move_a}, moves),
    do: not Enum.any?(moves, fn {elf_b, move_b} -> elf_a != elf_b and move_a == move_b end)

  defp suggest(map, elf, round) do
    [one, two, three, four] = directions(round)

    cond do
      not has_neighbor?(map, elf) -> elf
      direction_free?(map, elf, one) -> elf |> neighbors(one) |> Enum.at(1)
      direction_free?(map, elf, two) -> elf |> neighbors(two) |> Enum.at(1)
      direction_free?(map, elf, three) -> elf |> neighbors(three) |> Enum.at(1)
      direction_free?(map, elf, four) -> elf |> neighbors(four) |> Enum.at(1)
      true -> elf
    end
  end

  @priorities %{
    "1" => [:north, :south, :west, :east],
    "2" => [:south, :west, :east, :north],
    "3" => [:west, :east, :north, :south],
    "0" => [:east, :north, :south, :west]
  }

  defp directions(round), do: @priorities[round |> rem(4) |> to_string()]

  defp has_neighbor?(map, elf), do: elf |> Grid.neighbors(map, 8) |> Enum.any?(&elf?(map, &1))

  defp direction_free?(map, elf, direction),
    do: elf |> neighbors(direction) |> Enum.all?(&(not elf?(map, &1)))

  defp neighbors({x, y}, :north), do: [{x - 1, y - 1}, {x, y - 1}, {x + 1, y - 1}]
  defp neighbors({x, y}, :south), do: [{x - 1, y + 1}, {x, y + 1}, {x + 1, y + 1}]
  defp neighbors({x, y}, :west), do: [{x - 1, y - 1}, {x - 1, y}, {x - 1, y + 1}]
  defp neighbors({x, y}, :east), do: [{x + 1, y - 1}, {x + 1, y}, {x + 1, y + 1}]

  defp elves(map), do: map |> Grid.points() |> Enum.filter(&elf?(map, &1))

  defp elf?(map, point), do: Grid.get(map, point) == "#"
end
