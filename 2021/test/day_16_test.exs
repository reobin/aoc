defmodule AoC.Day16Test do
  use ExUnit.Case
  doctest AoC.Day16

  alias AoC.Day16

  describe "part 1" do
    test "sample 1" do
      input = "D2FE28"
      assert Day16.part_1(input) == 6
    end

    test "sample 2" do
      input = "38006F45291200"
      assert Day16.part_1(input) == 9
    end

    test "sample 3" do
      input = "EE00D40C823060"
      assert Day16.part_1(input) == 14
    end

    test "sample 4" do
      input = "8A004A801A8002F478"
      assert Day16.part_1(input) == 16
    end

    test "sample 5" do
      input = "620080001611562C8802118E34"
      assert Day16.part_1(input) == 12
    end

    test "sample 6" do
      input = "C0015000016115A2E0802F182340"
      assert Day16.part_1(input) == 23
    end

    test "sample 7" do
      input = "A0016C880162017C3686B18A3D4780"
      assert Day16.part_1(input) == 31
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "C200B40A82"
      assert Day16.part_2(input) == 3
    end
  end
end
