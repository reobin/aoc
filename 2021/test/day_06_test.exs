defmodule AoC.Day06Test do
  use ExUnit.Case
  doctest AoC.Day06

  alias AoC.Day06

  describe "part 1" do
    test "sample 1" do
      input = "3,4,3,1,2"
      assert Day06.part_1(input, 18) == 26
    end

    test "sample 2" do
      input = "3,4,3,1,2"
      assert Day06.part_1(input) == 5934
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "3,4,3,1,2"
      assert Day06.part_2(input) == 26984457539
    end
  end
end
