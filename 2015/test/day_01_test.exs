defmodule AoC.Day01Test do
  use ExUnit.Case
  doctest AoC.Day01

  alias AoC.Day01

  describe "part 1" do
    test "sample 1" do
      assert Day01.part_1("()()") == 0
      assert Day01.part_1("(())") == 0
    end

    test "sample 2" do
      assert Day01.part_1("(((") == 3
      assert Day01.part_1("(()(()(") == 3
      assert Day01.part_1("))(((((") == 3
    end

    test "sample 3" do
      assert Day01.part_1("())") == -1
      assert Day01.part_1("))(") == -1
    end

    test "sample 4" do
      assert Day01.part_1(")))") == -3
      assert Day01.part_1(")())())") == -3
    end
  end

  describe "part 2" do
    test "sample 1" do
      assert Day01.part_2(")") == 1
    end

    test "sample 2" do
      assert Day01.part_2("()())") == 5
    end
  end
end
