defmodule AoC2022.Day10 do
  @moduledoc """
  https://adventofcode.com/2022/day/10
  """

  @image_width 40
  @pixel_count 240

  def part_1(input) do
    image = input |> parse() |> run()
    [20, 60, 100, 140, 180, 220] |> Enum.map(&(&1 * Map.get(image, &1))) |> Enum.sum()
  end

  def part_2(input), do: input |> parse() |> run() |> draw()

  defp run(instructions), do: run(instructions, 0, 1, %{})
  defp run(_instructions, @pixel_count, _x, image), do: image
  defp run([], _cycle, _x, image), do: image

  defp run([{:noop, _} | instructions], cycle, x, image) do
    image = Map.put(image, cycle + 1, x)
    run(instructions, cycle + 1, x, image)
  end

  defp run([{:addx, inc} | instructions], cycle, x, image) do
    image = image |> Map.put(cycle + 1, x) |> Map.put(cycle + 2, x)
    run(instructions, cycle + 2, x + inc, image)
  end

  defp draw(image) do
    image
    |> Enum.sort()
    |> Enum.map(&draw_pixel/1)
    |> Enum.chunk_every(@image_width)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
  end

  defp draw_pixel({cycle, x}) do
    window = [x - 1, x, x + 1]
    pixel = rem(cycle - 1, @image_width)
    if pixel in window, do: "#", else: "."
  end

  defp parse(input), do: input |> String.split("\n") |> Enum.map(&parse_line/1)
  defp parse_line(line), do: line |> String.split(" ") |> parse_instruction()
  defp parse_instruction(["noop"]), do: {:noop, 0}
  defp parse_instruction(["addx", x]), do: {:addx, String.to_integer(x)}
end
