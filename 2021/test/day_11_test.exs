defmodule AoC2021.Day11Test do
  use ExUnit.Case
  doctest AoC2021.Day11

  alias AoC2021.Day11

  describe "part 1" do
    test "sample 1" do
      input = "5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526"

      assert Day11.part_1(input) == 1656
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526"

      assert Day11.part_2(input) == 195
    end
  end
end
