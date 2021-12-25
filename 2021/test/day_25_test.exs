defmodule AoC.Day25Test do
  use ExUnit.Case
  doctest AoC.Day25

  alias AoC.Day25

  describe "part 1" do
    test "sample 1" do
      input = "v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>"
      assert Day25.part_1(input) == 58
    end
  end
end
