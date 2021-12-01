defmodule AoC.Day01Test do
  use ExUnit.Case
  doctest AoC.Day01

  alias AoC.Day01

  describe "part 1" do
    test "sample 1" do
      input = "199
200
208
210
200
207
240
269
260
263"

      assert Day01.part_1(input) == 7
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "199
200
208
210
200
207
240
269
260
263"

      assert Day01.part_2(input) == 5
    end
  end
end
