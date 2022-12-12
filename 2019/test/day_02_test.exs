defmodule AoC2019.Day02Test do
  use ExUnit.Case
  doctest AoC2019.Day02

  alias AoC2019.Day02

  describe "part 1" do
    test "sample 1" do
      input = "1,12,2,0,99,5,6,0,99,0,0,0,0,0"
      assert Day02.part_1(input) == 2
    end
  end
end
