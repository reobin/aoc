defmodule AoC2021.Day12Test do
  use ExUnit.Case
  doctest AoC2021.Day12

  alias AoC2021.Day12

  describe "part 1" do
    test "sample 1" do
      input = "start-A
start-b
A-c
A-b
b-d
A-end
b-end"

      assert Day12.part_1(input) == 10
    end

    test "sample 2" do
      input = "dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc"

      assert Day12.part_1(input) == 19
    end

    test "sample 3" do
      input = "fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW"

      assert Day12.part_1(input) == 226
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "start-A
start-b
A-c
A-b
b-d
A-end
b-end"

      assert Day12.part_2(input) == 36
    end
  end
end
