defmodule AoC.Day05Test do
  use ExUnit.Case
  doctest AoC.Day05

  alias AoC.Day05

  describe "part 1" do
    test "sample 1" do
      input = "3,2,999,1,1,0,4,0"
      assert Day05.part_1(input) == 4
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "3,2,999,1,7,4,0,8,104,1"
      assert Day05.part_2(input) == 1
    end
  end
end
