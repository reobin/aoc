defmodule AoC2022.Day12Test do
  use ExUnit.Case
  doctest AoC2022.Day12

  alias AoC2022.Day12

  describe "part 1" do
    test "sample 1" do
      assert Day12.part_1("Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi") == 31
    end
  end

  describe "part 2" do
    test "sample 1" do
      assert Day12.part_2("Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi") == 29
    end
  end
end
