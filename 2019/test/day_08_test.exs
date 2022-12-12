defmodule AoC2019.Day08Test do
  use ExUnit.Case
  doctest AoC2019.Day08

  alias AoC2019.Day08

  describe "part 1" do
    test "sample 1" do
      input = "121456789012"
      assert Day08.part_1(input, width: 3, height: 2) == 2
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "0222112222120000"

      assert Day08.part_2(input, width: 2, height: 2) == " ●
● 
"
    end
  end
end
