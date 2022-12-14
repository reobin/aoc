defmodule AoC2022.Day14Test do
  use ExUnit.Case
  doctest AoC2022.Day14

  alias AoC2022.Day14

  describe "part 1" do
    test "sample 1" do
      assert Day14.part_1("498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9") == 24
    end
  end

  describe "part 2" do
    test "sample 1" do
      assert Day14.part_2("498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9") == 93
    end
  end
end
