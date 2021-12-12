defmodule AoC.Day08 do
  @moduledoc """
  https://adventofcode.com/2019/day/8
  """

  def part_1(input, options \\ []) do
    default_options = %{width: 25, height: 6}
    options = Enum.into(options, default_options)

    input
    |> get_layers(options.width, options.height)
    |> Enum.min_by(fn layer -> layer |> Map.values() |> Enum.count(&(&1 == "0")) end)
    |> then(fn layer ->
      ones = layer |> Map.values() |> Enum.count(&(&1 == "1"))
      twos = layer |> Map.values() |> Enum.count(&(&1 == "2"))
      ones * twos
    end)
  end

  def part_2(input, options \\ []) do
    default_options = %{width: 25, height: 6}
    options = Enum.into(options, default_options)

    layers = get_layers(input, options.width, options.height)

    for(x <- 0..(options.width - 1), y <- 0..(options.height - 1), do: {x, y})
    |> Enum.reduce(%{}, fn pixel, image ->
      layer = Enum.find(layers, fn layer -> layer[pixel] != "2" end)
      Map.put(image, pixel, Map.get(layer, pixel))
    end)
    |> print_image(options.width, options.height)
  end

  defp get_layers(input, width, height) do
    pixel_per_layer = width * height

    input
    |> String.split("", trim: true)
    |> Enum.chunk_every(pixel_per_layer)
    |> Enum.map(fn chunk ->
      for(x <- 0..(width - 1), y <- 0..(height - 1), do: {x, y})
      |> Enum.reduce(%{}, fn {x, y}, layer ->
        pixel = chunk |> Enum.chunk_every(width) |> Enum.at(y) |> Enum.at(x)
        Map.put(layer, {x, y}, pixel)
      end)
    end)
  end

  defp print_image(image, width, height) do
    Enum.reduce(0..(height - 1), "", fn y, output ->
      Enum.reduce(0..(width - 1), output, fn x, output ->
        output <> pixel_to_string(image[{x, y}])
      end) <> "\n"
    end)
  end

  defp pixel_to_string("1"), do: "●"
  defp pixel_to_string("0"), do: " "
end
