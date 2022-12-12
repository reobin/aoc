defmodule AoC2019.Day13 do
  @moduledoc """
  https://adventofcode.com/2019/day/13
  """

  alias AoC2019.Modules.Intcode
  alias AoC.Grid

  @wall "□"
  @block "■"
  @paddle "▁"
  @ball "●"
  @empty " "

  def part_1(input),
    do: input |> Intcode.initialize() |> run() |> Enum.count(&(elem(&1, 1) == @block))

  def part_2(input), do: ("2" <> String.slice(input, 1..-1)) |> Intcode.initialize() |> run()

  defp run(program), do: run(program, %{})
  defp run(%{output: :halt}, screen), do: screen

  defp run(program, screen) do
    paint(screen)

    ball = get_position(screen, @ball)
    paddle = get_position(screen, @paddle)
    input = get_input(ball, paddle)

    %{output: x} = program = Intcode.run(program, input)
    %{output: y} = program = Intcode.run(program)
    %{output: id} = program = Intcode.run(program)

    cond do
      x == -1 and screen |> get_position(@block) |> is_nil() -> id
      x == -1 -> run(program, screen)
      true -> run(program, Map.put(screen, {x, y}, print(id)))
    end
  end

  defp paint(screen) do
    IEx.Helpers.clear()
    Grid.print(screen)
    Process.sleep(5)
  end

  defp print(1), do: @wall
  defp print(2), do: @block
  defp print(3), do: @paddle
  defp print(4), do: @ball
  defp print(_), do: @empty

  defp get_position(screen, item),
    do: screen |> Grid.points() |> Enum.find(&(Grid.get(screen, &1) == item))

  defp get_input({bx, _by}, {bx, _py}), do: [0]
  defp get_input({bx, _by}, {px, _py}) when bx > px, do: [1]
  defp get_input(_ball, _paddle), do: [-1]
end
