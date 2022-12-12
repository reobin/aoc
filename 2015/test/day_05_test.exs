defmodule AoC.Day05Test do
  use ExUnit.Case
  doctest AoC.Day05

  alias AoC.Day05

  describe "part 1" do
    test "sample 1" do
      input = "ugknbfddgicrmopn
aaa
jchzalrnumimnmhp
haegwjzuvuyypxyu
dvszwmarrgswjxmb"
      assert Day05.part_1(input) == 2
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "qjhvhtzxzqqjkmpb
xxyxx
uurcxstgmygtbstg
ieodomkazucvgmuy"
      assert Day05.part_2(input) == 2
    end
  end
end
