defmodule AoC2022.Day07Test do
  use ExUnit.Case
  doctest AoC2022.Day07

  alias AoC2022.Day07

  describe "part 1" do
    test "sample 1" do
      input = "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k"
      assert Day07.part_1(input) == 95_437
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k"
      assert Day07.part_2(input) == 24_933_642
    end
  end
end
