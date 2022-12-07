defmodule AoC.Day03 do
  @moduledoc """
  https://adventofcode.com/2015/day/3
  """

  def part_1(input) do
    initial = %{} |> Map.put(:position, {0, 0}) |> Map.put({0, 0}, true)

    input
    |> String.split("", trim: true)
    |> Enum.reduce(initial, &move/2)
    |> Map.keys()
    |> Enum.filter(&(&1 != :position))
    |> Enum.count()
  end

  def part_2(input) do
    initial = %{} |> Map.put(:position, {0, 0}) |> Map.put({0, 0}, true)

    santa_moves = input |> String.split("", trim: true) |> split(1)
    robot_santa_moves = input |> String.split("", trim: true) |> split(2)

    santa_houses = santa_moves |> Enum.reduce(initial, &move/2) |> Map.keys()
    robot_santa_houses = robot_santa_moves |> Enum.reduce(initial, &move/2) |> Map.keys()

    (santa_houses ++ robot_santa_houses)
    |> Enum.filter(&(&1 != :position))
    |> Enum.uniq()
    |> Enum.count()
  end

  defp split(i, 1) do
    i
    |> Enum.with_index()
    |> Enum.filter(fn {_, i} -> is_pair?(i) end)
    |> Enum.map(&elem(&1, 0))
  end

  defp split(i, 2) do
    i
    |> Enum.with_index()
    |> Enum.filter(fn {_, i} -> not is_pair?(i) end)
    |> Enum.map(&elem(&1, 0))
  end

  defp is_pair?(i), do: rem(i, 2) == 0

  defp move("^", %{position: {x, y}} = state),
    do: state |> Map.put(:position, {x, y - 1}) |> Map.put({x, y - 1}, true)

  defp move(">", %{position: {x, y}} = state),
    do: state |> Map.put(:position, {x + 1, y}) |> Map.put({x + 1, y}, true)

  defp move("v", %{position: {x, y}} = state),
    do: state |> Map.put(:position, {x, y + 1}) |> Map.put({x, y + 1}, true)

  defp move("<", %{position: {x, y}} = state),
    do: state |> Map.put(:position, {x - 1, y}) |> Map.put({x - 1, y}, true)
end
