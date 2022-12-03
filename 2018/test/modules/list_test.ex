defmodule AoC.Modules.ListTest do
  use ExUnit.Case
  doctest AoC.Modules.List

  alias AoC.Modules.List

  describe "&pairs/1" do
    test "should return all possible unique pairs" do
      assert List.pairs([1, 2, 3]) == [[1, 2], [1, 3], [2, 3]]
      assert List.pairs(["abc", "def", "zyx"]) == [["abc", "def"], ["abc", "zyx"], ["def", "zyx"]]
    end
  end
end
