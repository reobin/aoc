defmodule AoC.Day13 do
  @moduledoc """
  https://adventofcode.com/2021/day/13
  """

  alias AoC.Modules.Grid

  def part_1(input) do
    {paper, [instruction | _instructions]} = interpret_sheet(input)
    instruction |> fold(paper) |> Map.values() |> Enum.count(&(&1 == "#"))
  end

  def part_2(input) do
    {paper, instructions} = interpret_sheet(input)

    instructions
    |> Enum.reduce(paper, &fold/2)
    |> Grid.to_string(replace_nil_with: ".")
  end

  defp fold({coordinate, line}, paper) do
    paper
    |> Grid.get_points()
    |> Enum.filter(&(elem(&1, if(coordinate == :x, do: 0, else: 1)) >= line))
    |> Enum.reduce(paper, fn {x, y}, paper ->
      row = if coordinate == :x, do: line, else: x
      column = if coordinate == :y, do: line, else: y

      paper |> Map.delete({x, y}) |> Map.put({row - x + row, column - y + column}, "#")
    end)
  end

  defp interpret_sheet(input) do
    input
    |> String.split("\n\n", trim: true)
    |> then(fn [p, i] -> {get_paper(p), get_instructions(i)} end)
  end

  defp get_paper(paper) do
    paper
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line |> String.split(",") |> Enum.map(&String.to_integer/1) |> then(fn [x, y] -> {x, y} end)
    end)
    |> Enum.reduce(%{}, &Map.put(&2, &1, "#"))
  end

  defp get_instructions(instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      coordinate = if String.contains?(line, "x"), do: :x, else: :y
      [_, line] = String.split(line, "=")
      {coordinate, String.to_integer(line)}
    end)
  end
end
