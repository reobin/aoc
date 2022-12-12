defmodule AoC2021.Day21Test do
  use ExUnit.Case
  doctest AoC2021.Day21

  alias AoC2021.Day21

  describe "part 1" do
    test "sample 1" do
      input = "Player 1 starting position: 4
Player 2 starting position: 8"
      assert Day21.part_1(input) == 739_785
    end
  end

  describe "part 2" do
    test "sample 1" do
      input = "Player 1 starting position: 4
Player 2 starting position: 8"
      assert Day21.part_2(input) == 444_356_092_776_315
    end
  end
end
