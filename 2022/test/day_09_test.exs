defmodule AoC2022.Day09Test do
  use ExUnit.Case
  doctest AoC2022.Day09

  alias AoC2022.Day09

  describe "part 1" do
    test "sample 1" do
      input = "R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2"
      assert Day09.part_1(input) == 13
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2"
      assert Day09.part_2(input) == 1
    end

    test "sample 2" do
      input = "R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20"
      assert Day09.part_2(input) == 36
    end
  end
end
