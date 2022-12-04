defmodule AoC.Day04Test do
  use ExUnit.Case
  doctest AoC.Day04

  alias AoC.Day04

  describe "part 1" do
    test "sample 1" do
      input = "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8"
      assert Day04.part_1(input) == 2
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8"
      assert Day04.part_2(input) == 4
    end
  end
end
