defmodule AoC.Day02Test do
  use ExUnit.Case
  doctest AoC.Day02

  alias AoC.Day02

  describe "part 1" do
    test "sample 1" do
      input = "abcdef
bababc
abbcde
abcccd
aabcdd
abcdee
ababab"
      assert Day02.part_1(input) == 12
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz"
      assert Day02.part_2(input) == "fgij"
    end
  end
end
