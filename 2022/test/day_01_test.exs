defmodule AoC.Day01Test do
  use ExUnit.Case
  doctest AoC.Day01

  alias AoC.Day01

  describe "part 1" do
    test "sample 1" do
      input = "1000
2000
3000

4000

5000
6000

7000
8000
9000

10000"
      assert Day01.part_1(input) == 24_000
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "1000
2000
3000

4000

5000
6000

7000
8000
9000

10000"
      assert Day01.part_2(input) == 45_000
    end
  end
end
