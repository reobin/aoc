defmodule AoC.Day14Test do
  use ExUnit.Case
  doctest AoC.Day14

  alias AoC.Day14

  describe "part 1" do
    test "sample 1" do
      input = "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"

      assert Day14.part_1(input) == 1588
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"

      assert Day14.part_2(input) == 2_188_189_693_529
    end
  end
end
