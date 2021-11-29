defmodule AoC.Day01Test do
  use ExUnit.Case
  doctest AoC.Day01

  alias AoC.Day01

  describe "part 1" do
    test "part 1" do
      input = "test input"
      assert Day01.part_1(input) == "part 1"
    end
  end

  describe "part 2" do
    test "part 2" do
      input = "test input"
      assert Day01.part_2(input) == "part 2"
    end
  end
end
