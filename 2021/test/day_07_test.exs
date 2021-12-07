defmodule AoC.Day07Test do
  use ExUnit.Case
  doctest AoC.Day07

  alias AoC.Day07

  describe "part 1" do
    test "sample 1" do
      input = "16,1,2,0,4,2,7,1,2,14"
      assert Day07.part_1(input) == 37
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "16,1,2,0,4,2,7,1,2,14"
      assert Day07.part_2(input) == 168
    end
  end
end
