defmodule AoC.Day04Test do
  use ExUnit.Case
  doctest AoC.Day04

  alias AoC.Day04

  describe "part 1" do
    test "sample 1" do
      assert Day04.part_1("abcdef") == 609_043
    end
  end
end
