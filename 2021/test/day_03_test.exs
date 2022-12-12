defmodule AoC2021.Day03Test do
  use ExUnit.Case
  doctest AoC2021.Day03

  alias AoC2021.Day03

  describe "part 1" do
    test "sample 1" do
      input = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010"

      assert Day03.part_1(input) == 198
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010"

      assert Day03.part_2(input) == 230
    end
  end
end
