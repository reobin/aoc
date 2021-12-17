defmodule AoC.Day17Test do
  use ExUnit.Case
  doctest AoC.Day17

  alias AoC.Day17

  describe "part 1" do
    test "sample 1" do
      input = "target area: x=20..30, y=-10..-5"
      assert Day17.part_1(input) == 45
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "target area: x=20..30, y=-10..-5"
      assert Day17.part_2(input) == 112
    end
  end
end
