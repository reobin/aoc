defmodule AoC2019.Day16Test do
  use ExUnit.Case
  doctest AoC2019.Day16

  alias AoC2019.Day16

  describe "part 1" do
    test "sample 0" do
      assert Day16.part_1("12345678", 4) == "01029498"
    end

    test "sample 1" do
      assert Day16.part_1("80871224585914546619083218645595") == "24176176"
    end

    test "sample 2" do
      assert Day16.part_1("19617804207202209144916044189917") == "73745418"
    end

    test "sample 3" do
      assert Day16.part_1("69317163492948606335995924319873") == "52432133"
    end
  end

  describe "part 2" do
    test "sample 1" do
      assert Day16.part_2("03036732577212944063491565474664") == "84462026"
    end

    test "sample 2" do
      assert Day16.part_2("02935109699940807407585447034323") == "78725270"
    end

    test "sample 3" do
      assert Day16.part_2("03081770884921959731165446850517") == "53553731"
    end
  end
end
