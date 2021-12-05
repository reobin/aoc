defmodule AoC.Day05Test do
  use ExUnit.Case
  doctest AoC.Day05

  alias AoC.Day05

  describe "part 1" do
    test "sample 1" do
      input = "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"

      assert Day05.part_1(input) == 5
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"

      assert Day05.part_2(input) == 12
    end
  end
end
