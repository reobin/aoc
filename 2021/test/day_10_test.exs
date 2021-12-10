defmodule AoC.Day10Test do
  use ExUnit.Case
  doctest AoC.Day10

  alias AoC.Day10

  describe "part 1" do
    test "sample 1" do
      input = "[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]"

      assert Day10.part_1(input) == 26397
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
(((({<>}<{<{<>}{[]{[]{}
{<[[]]>}<{[{[{[]{()[[[]
<{([{{}}[<[[[<>{}]]]>[]]"

      assert Day10.part_2(input) == 288957
    end
  end
end
