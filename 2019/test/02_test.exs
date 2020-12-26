defmodule AoC.Day02Test do
  use ExUnit.Case
  doctest AoC.Day02

  alias AoC.Day02

  test "part 1" do
    input = "1,9,10,3,2,3,11,0,99,30,40,50,60"
    expected_program = [3100, 12, 62, 3, 2, 3, 11, 0, 99, 30, 40, 50, 60]

    expected_result = expected_program |> Enum.at(0)
    assert Day02.part_1(input) == expected_result
  end
end
