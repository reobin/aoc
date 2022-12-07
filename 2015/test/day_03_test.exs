defmodule AoC.Day03Test do
  use ExUnit.Case
  doctest AoC.Day03

  alias AoC.Day03

  describe "part 1" do
    test "sample 1" do
      input = ">"
      assert Day03.part_1(input) == 2
    end

    test "sample 2" do
      input = "^>v<"
      assert Day03.part_1(input) == 4
    end

    test "sample 3" do
      input = "^v^v^v^v^v"
      assert Day03.part_1(input) == 2
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "^v"
      assert Day03.part_2(input) == 3
    end

    test "sample 2" do
      input = "^>v<"
      assert Day03.part_2(input) == 3
    end

    test "sample 3" do
      input = "^v^v^v^v^v"
      assert Day03.part_2(input) == 11
    end
  end
end
