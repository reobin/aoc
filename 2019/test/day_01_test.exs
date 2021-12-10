defmodule AoC.Day01Test do
  use ExUnit.Case
  doctest AoC.Day01

  alias AoC.Day01

  describe "part 1" do
    test "sample 1" do
      input = "12
14
1969
100756"

      assert Day01.part_1(input) == 34241
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "14
1969
100756"

      assert Day01.part_2(input) == 51314
    end
  end
end
