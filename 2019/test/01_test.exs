defmodule AoC.Day01Test do
  use ExUnit.Case
  doctest AoC.Day01

  test "part 1" do
    input = "100756
1969"

    assert AoC.Day01.part_1(input) == 33583 + 654
  end

  test "part 2" do
    input = "1969
100756"

    assert AoC.Day01.part_2(input) == 966 + 50346
  end
end
