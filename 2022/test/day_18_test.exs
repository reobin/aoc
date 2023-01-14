defmodule AoC2022.Day18Test do
  use ExUnit.Case
  doctest AoC2022.Day18

  alias AoC2022.Day18

  describe "part 1" do
    test "sample 1" do
      assert Day18.part_1("1,1,1
2,1,1") == 10
    end

    test "sample 2" do
      assert Day18.part_1("2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5") == 64
    end
  end

  describe "part 2" do
    test "single cube" do
      assert Day18.part_2("1,1,1") == 6
    end

    test "cube of size 2" do
      assert Day18.part_2("1,1,1
2,1,1
1,2,1
2,2,1
1,1,2
2,1,2
1,2,2
2,2,2") == 24
    end

    test "cube of size 2 with missing chunk" do
      assert Day18.part_2("2,1,1
1,2,1
2,2,1
1,1,2
2,1,2
1,2,2
2,2,2") == 24
    end

    test "full cube of size 3" do
      assert Day18.part_2("1,1,1
2,1,1
3,1,1
1,2,1
2,2,1
3,2,1
1,3,1
2,3,1
3,3,1
1,1,2
2,1,2
3,1,2
1,2,2
2,2,2
3,2,2
1,3,2
2,3,2
3,3,2
1,1,3
2,1,3
3,1,3
1,2,3
2,2,3
3,2,3
1,3,3
2,3,3
3,3,3") == 54
    end

    test "cube of size 3 with empty middle" do
      assert Day18.part_2("1,1,1
2,1,1
3,1,1
1,2,1
2,2,1
3,2,1
1,3,1
2,3,1
3,3,1
1,1,2
2,1,2
3,1,2
1,2,2
3,2,2
1,3,2
2,3,2
3,3,2
1,1,3
2,1,3
3,1,3
1,2,3
2,2,3
3,2,3
1,3,3
2,3,3
3,3,3") == 54
    end

    test "sample" do
      assert Day18.part_2("2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5") == 58
    end
  end
end
