defmodule AoC.Day13Test do
  use ExUnit.Case
  doctest AoC.Day13

  alias AoC.Day13

  describe "part 1" do
    test "sample 1" do
      input = "6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5"

      assert Day13.part_1(input) == 17
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5"

      assert Day13.part_2(input) == "#####
#...#
#...#
#...#
#####"
    end
  end
end
