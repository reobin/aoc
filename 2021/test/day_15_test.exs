defmodule AoC.Day15Test do
  use ExUnit.Case
  doctest AoC.Day15

  alias AoC.Day15

  describe "part 1" do
    test "sample 1" do
      input = "1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581"

      assert Day15.part_1(input) == 40
    end

    test "sample 2" do
      input = "11119
99919
91119
91999
91111"

      assert Day15.part_1(input) == 12
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581"

      assert Day15.part_2(input) == 315
    end
  end
end
