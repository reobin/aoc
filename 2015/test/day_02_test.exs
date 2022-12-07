defmodule AoC.Day02Test do
  use ExUnit.Case
  doctest AoC.Day02

  alias AoC.Day02

  describe "part 1" do
    test "sample 1" do
      assert Day02.part_1("2x3x4") == 58
    end

    test "sample 2" do
      assert Day02.part_1("1x1x10") == 43
    end

    test "sample 3" do
      input = "1x1x10
2x3x4"
      assert Day02.part_1(input) == 43 + 58
    end
  end

  describe "part 2" do
    test "sample 1" do
      assert Day02.part_2("2x3x4") == 34
    end

    test "sample 2" do
      assert Day02.part_2("1x1x10") == 14
    end

    test "sample 3" do
      input = "1x1x10
2x3x4"
      assert Day02.part_2(input) == 34 + 14
    end
  end
end
