defmodule AoC2022.Day20Test do
  use ExUnit.Case
  doctest AoC2022.Day20

  alias AoC2022.Day20

  describe "part 1" do
    test "sample 1" do
      assert Day20.part_1("1
2
-3
3
-2
0
4") == 3
    end
  end

  describe "part 2" do
    test "sample 1" do
      assert Day20.part_2("1
2
-3
3
-2
0
4") == 1_623_178_306
    end
  end
end
