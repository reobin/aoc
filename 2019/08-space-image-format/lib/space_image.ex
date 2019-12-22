defmodule SpaceImage do
  def get_pixels(path),
    do: File.read!(path)

  def count_digit(layer, str_digit),
    do:
      Enum.reduce(String.split(layer, ""), 0, fn char, acc ->
        if char == str_digit, do: acc + 1, else: acc
      end)

  def find_best_layer(layers) do
    [head | tail] = layers

    best_layer =
      Enum.reduce(
        tail,
        %{layer: head, zero_count: count_digit(head, "0")},
        fn layer, best_layer ->
          zero_count = count_digit(layer, "0")

          if zero_count < best_layer.zero_count,
            do: %{layer: layer, zero_count: zero_count},
            else: best_layer
        end
      )

    best_layer.layer
  end

  def get_layers(pixels, width, height) do
    pixel_count = String.length(pixels)
    pixel_count_per_layer = width * height
    layer_count = Kernel.round(pixel_count / pixel_count_per_layer)

    Enum.reduce(0..(layer_count - 1), [], fn layer_index, layers ->
      start_index = layer_index * pixel_count_per_layer
      end_index = (layer_index + 1) * pixel_count_per_layer - 1

      layers ++ [String.slice(pixels, start_index..end_index)]
    end)
  end

  def decode_image(layers) do
    [head | tail] = layers

    Enum.reduce(tail, head, fn layer, acc ->
      acc
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {char, index} ->
        if String.at(acc, index) == "2",
          do: String.at(layer, index),
          else: char
      end)
      |> Enum.join()
    end)
  end

  def draw(decoded_image, width, height) do
    Enum.each(0..(height - 1), fn y ->
      start_index = y * width
      end_index = (y + 1) * width - 1

      IO.puts(
        decoded_image
        |> String.slice(start_index..end_index)
        |> String.replace("0", "█")
        |> String.replace("1", " ")
      )
    end)
  end
end
