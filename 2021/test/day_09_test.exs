defmodule AoC.Day09Test do
  use ExUnit.Case
  doctest AoC.Day09

  alias AoC.Day09

  describe "part 1" do
    test "sample 1" do
      input = "2199943210
3987894921
9856789892
8767896789
9899965678"

      assert Day09.part_1(input) == 15
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "2199943210
3987894921
9856789892
8767896789
9899965678"

      assert Day09.part_2(input) == 1134
    end
  end
end
