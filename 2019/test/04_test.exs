defmodule AoC.Day04Test do
  use ExUnit.Case
  doctest AoC.Day04

  test "part 1" do
    input = "111111-111115"
    assert AoC.Day04.part_1(input) == 5
  end

  test "part 2" do
    input = "111111-111115"
    assert AoC.Day04.part_2(input) == 0
  end
end
