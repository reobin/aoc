defmodule AoC.Day05Test do
  use ExUnit.Case
  doctest AoC.Day05

  alias AoC.Day05

  describe "part 1" do
    test "sample 1" do
      input = "    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2"
      assert Day05.part_1(input) == "CMZ"
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2"
      assert Day05.part_2(input) == "MCD"
    end
  end
end
