defmodule AoC.Day12Test do
  use ExUnit.Case
  doctest AoC.Day12

  alias AoC.Day12

  describe "part 1" do
    test "sample 1" do
      input = "<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>"

      assert Day12.part_1(input, 10) == 179
    end

    test "sample 2" do
      input = "<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>"

      assert Day12.part_1(input, 100) == 1940
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>"

      assert Day12.part_2(input) == 2772
    end
  end
end
