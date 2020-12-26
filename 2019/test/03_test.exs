defmodule AoC.Day03Test do
  use ExUnit.Case
  doctest AoC.Day03

  test "part 1" do
    input = "R8,U5,L5,D3
U7,R6,D4,L4"
    assert AoC.Day03.part_1(input) == 6

    input = "R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83"
    assert AoC.Day03.part_1(input) == 159

    input = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    assert AoC.Day03.part_1(input) == 135
  end

  test "part 2" do
    input = "R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83"
    assert AoC.Day03.part_2(input) == 610

    input = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    assert AoC.Day03.part_2(input) == 410
  end
end
