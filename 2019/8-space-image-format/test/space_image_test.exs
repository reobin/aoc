defmodule SpaceImageTest do
  use ExUnit.Case
  doctest SpaceImage

  test "get pixels from path" do
    path = "./input.txt"

    assert String.length(SpaceImage.get_pixels(path)) > 0
  end

  test "get layers from pixels" do
    input = "123456789012"
    width = 3
    height = 2

    assert SpaceImage.get_layers(input, width, height) == ["123456", "789012"]
  end

  test "find best layer" do
    layers = ["123456", "789012"]

    assert SpaceImage.find_best_layer(layers) == "123456"
  end

  test "count digit in layer" do
    layer = "123444"

    assert SpaceImage.count_digit(layer, "1") == 1
    assert SpaceImage.count_digit(layer, "4") == 3
  end
end
