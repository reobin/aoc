defmodule AoC2021.Day21 do
  @moduledoc """
  https://adventofcode.com/2021/day/21
  """

  def part_1(input) do
    [position_1, position_2] = get_starting_positions(input)

    player_1 = %{position: position_1, score: 0}
    player_2 = %{position: position_2, score: 0}

    play(%{player_1: player_1, player_2: player_2, die: 1}, 1)
  end

  defp play(state, turn) do
    {roll, die} = roll_die_100(state.die)

    player_key = if rem(turn, 2) == 0, do: :player_2, else: :player_1
    player = Map.get(state, player_key)

    position = get_position(player.position, roll)
    player = %{position: position, score: player.score + position}

    if player.score >= 1000 do
      loser_key = if player_key == :player_1, do: :player_2, else: :player_1
      lowest_score = state |> Map.get(loser_key) |> Map.get(:score)
      lowest_score * turn * 3
    else
      state |> Map.put(player_key, player) |> Map.put(:die, die) |> play(turn + 1)
    end
  end

  defp roll_die_100(98), do: {98 + 99 + 100, 1}
  defp roll_die_100(99), do: {99 + 100 + 1, 2}
  defp roll_die_100(100), do: {100 + 1 + 2, 3}
  defp roll_die_100(die), do: {die + die + 1 + die + 2, die + 3}

  def part_2(input) do
    [position_1, position_2] = get_starting_positions(input)

    player_1 = %{position: position_1, score: 0}
    player_2 = %{position: position_2, score: 0}

    dirac(%{player_1: player_1, player_2: player_2}, 1)
  end

  @rolls for(d1 <- 1..3, d2 <- 1..3, d3 <- 1..3, do: Enum.sum([d1, d2, d3])) |> Enum.frequencies()

  defp dirac(state, turn),
    do: @rolls |> Enum.map(fn {roll, count} -> count * dirac(state, turn, roll) end) |> Enum.sum()

  defp dirac(state, turn, roll) do
    player_key = if rem(turn, 2) == 0, do: :player_2, else: :player_1
    player = Map.get(state, player_key)

    position = get_position(player.position, roll)

    player = %{position: position, score: player.score + position}

    state = Map.put(state, player_key, player)

    if state.player_1.score >= 21 or state.player_2.score >= 21 do
      if state.player_1.score > state.player_2.score, do: 1, else: 0
    else
      dirac(state, turn + 1)
    end
  end

  defp get_position(pos, die) when pos + die > 19, do: get_position(pos, die - 10)
  defp get_position(pos, die) when pos + die > 10, do: rem(pos + die, 10)
  defp get_position(pos, die), do: pos + die

  defp get_starting_positions(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [_, position] = String.split(line, ": ")
      String.to_integer(position)
    end)
  end
end
