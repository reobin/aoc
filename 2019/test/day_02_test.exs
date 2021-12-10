defmodule AoC.Day02Test do
  use ExUnit.Case
  doctest AoC.Day02

  alias AoC.Day02

  describe "part 1" do
    test "sample 1" do
      input = "1,12,2,0,99,5,6,0,99,0,0,0,0,0"
      assert Day02.part_1(input) == 2
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "test input"
      assert Day02.part_2(input) == 0
    end
  end
end