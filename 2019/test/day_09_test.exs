defmodule AoC2019.Day09Test do
  use ExUnit.Case
  doctest AoC2019.Day09

  alias AoC2019.Day09

  describe "part 1" do
    test "sample 1" do
      input = "104,1125899906842624,99"
      assert Day09.part_1(input) == 1_125_899_906_842_624
    end

    test "sample 2" do
      input = "1102,34915192,34915192,7,4,7,99,0"
      assert input |> Day09.part_1() |> Integer.to_string() |> String.length() == 16
    end

    test "sample 3" do
      input = "109,-1,4,1,99"
      assert Day09.part_1(input) == -1
    end

    test "sample 4" do
      input = "109,-1,104,1,99"
      assert Day09.part_1(input) == 1
    end

    test "sample 5" do
      input = "109,-1,204,1,99"
      assert Day09.part_1(input) == 109
    end

    test "sample 6" do
      input = "109,1,9,2,204,-6,99"
      assert Day09.part_1(input) == 204
    end

    test "sample 7" do
      input = "109,1,109,9,204,-6,99"
      assert Day09.part_1(input) == 204
    end

    test "sample 8" do
      input = "109,1,209,-1,204,-106,99"
      assert Day09.part_1(input) == 204
    end

    test "sample 9" do
      input = "109,1,3,3,204,2,99"
      assert Day09.part_1(input) == 1
    end

    test "sample 10" do
      input = "109,1,203,2,204,2,99"
      assert Day09.part_1(input) == 1
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "109,1,203,2,204,2,99"
      assert Day09.part_2(input) == 2
    end
  end
end
