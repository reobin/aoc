defmodule AoC.Day02Test do
  use ExUnit.Case
  doctest AoC.Day02

  alias AoC.Day02

  describe "part 1" do
    test "sample 1" do
      input = "forward 5
down 5
forward 8
up 3
down 8
forward 2"
      assert Day02.part_1(input) == 150
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "forward 5
down 5
forward 8
up 3
down 8
forward 2"
      assert Day02.part_2(input) == 900
    end
  end
end
