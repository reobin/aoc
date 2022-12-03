defmodule AoC.Day03Test do
  use ExUnit.Case
  doctest AoC.Day03

  alias AoC.Day03

  describe "part 1" do
    test "sample 1" do
      input = "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw"
      assert Day03.part_1(input) == 157
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw"
      assert Day03.part_2(input) == 70
    end
  end
end
