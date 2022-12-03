defmodule AoC.Day01Test do
  use ExUnit.Case
  doctest AoC.Day01

  alias AoC.Day01

  describe "part 1" do
    test "sample 1" do
      input = "+1
+1
+1"
      assert Day01.part_1(input) == 3
    end

    test "sample 2" do
      input = "+1
+1
-2"
      assert Day01.part_1(input) == 0
    end

    test "sample 3" do
      input = "-1
-2
-3"
      assert Day01.part_1(input) == -6
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "+1
-1"
      assert Day01.part_2(input) == 0
    end

    test "sample 2" do
      input = "+3
+3
+4
-2
-4"
      assert Day01.part_2(input) == 10
    end
  end
end
