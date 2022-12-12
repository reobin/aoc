defmodule AoC2022.Day02Test do
  use ExUnit.Case
  doctest AoC2022.Day02

  alias AoC2022.Day02

  describe "part 1" do
    test "sample 1" do
      input = "A Y
B X
C Z"
      assert Day02.part_1(input) == 15
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "A Y
B X
C Z"
      assert Day02.part_2(input) == 12
    end
  end
end
