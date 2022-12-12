defmodule AoC2019.Day06Test do
  use ExUnit.Case
  doctest AoC2019.Day06

  alias AoC2019.Day06

  describe "part 1" do
    test "sample 1" do
      input = "COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L"

      assert Day06.part_1(input) == 42
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN"

      assert Day06.part_2(input) == 4
    end

    test "sample 2" do
      input = "COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
I)YOU
I)SAN"

      assert Day06.part_2(input) == 0
    end
  end
end
