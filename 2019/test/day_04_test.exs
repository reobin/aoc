defmodule AoC.Day04Test do
  use ExUnit.Case
  doctest AoC.Day04

  alias AoC.Day04

  describe "part 1" do
    test "sample 1" do
      input = "111111-111111"
      assert Day04.part_1(input) == 1
    end

    test "sample 2" do
      input = "223450-223450"
      assert Day04.part_1(input) == 0
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "112233-112233"
      assert Day04.part_2(input) == 1
    end

    test "sample 2" do
      input = "123444-123444"
      assert Day04.part_2(input) == 0
    end
  end
end
