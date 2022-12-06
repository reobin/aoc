defmodule AoC.Day06Test do
  use ExUnit.Case
  doctest AoC.Day06

  alias AoC.Day06

  describe "part 1" do
    test "sample 1" do
      input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
      assert Day06.part_1(input) == 7
    end

    test "sample 2" do
      input = "bvwbjplbgvbhsrlpgdmjqwftvncz"
      assert Day06.part_1(input) == 5
    end

    test "sample 3" do
      input = "nppdvjthqldpwncqszvftbrmjlhg"
      assert Day06.part_1(input) == 6
    end

    test "sample 4" do
      input = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
      assert Day06.part_1(input) == 10
    end

    test "sample 5" do
      input = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
      assert Day06.part_1(input) == 11
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
      assert Day06.part_2(input) == 19
    end

    test "sample 2" do
      input = "bvwbjplbgvbhsrlpgdmjqwftvncz"
      assert Day06.part_2(input) == 23
    end

    test "sample 3" do
      input = "nppdvjthqldpwncqszvftbrmjlhg"
      assert Day06.part_2(input) == 23
    end

    test "sample 4" do
      input = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
      assert Day06.part_2(input) == 29
    end

    test "sample 5" do
      input = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
      assert Day06.part_2(input) == 26
    end
  end
end
