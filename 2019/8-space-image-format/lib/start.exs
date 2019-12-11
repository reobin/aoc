defmodule Start do
  def round_1 do
    path = "./input.txt"
    width = 25
    height = 6

    pixels = SpaceImage.get_pixels(path)

    layers = SpaceImage.get_layers(pixels, width, height)

    best_layer = SpaceImage.find_best_layer(layers)

    IO.puts(SpaceImage.count_digit(best_layer, "1") * SpaceImage.count_digit(best_layer, "2"))
  end
end

Start.round_1()
