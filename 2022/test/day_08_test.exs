defmodule AoC2022.Day08Test do
  use ExUnit.Case
  doctest AoC2022.Day08

  alias AoC2022.Day08

  describe "part 1" do
    test "sample 1" do
      input = "30373
25512
65332
33549
35390"
      assert Day08.part_1(input) == 21
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "30373
25512
65332
33549
35390"
      assert Day08.part_2(input) == 8
    end
  end
end
