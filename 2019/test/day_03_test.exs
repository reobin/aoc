defmodule AoC.Day03Test do
  use ExUnit.Case
  doctest AoC.Day03

  alias AoC.Day03

  describe "part 1" do
    test "sample 1" do
      input = "R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83"
      assert Day03.part_1(input) == 159
    end

    test "sample 2" do
      input = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
      assert Day03.part_1(input) == 135
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83"
      assert Day03.part_2(input) == 610
    end

    test "sample 2" do
      input = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
      assert Day03.part_2(input) == 410
    end
  end
end
