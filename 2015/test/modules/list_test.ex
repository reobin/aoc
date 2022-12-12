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

  describe "&unique?/1" do
    test "should return true if the list is only composed of unique elements" do
      assert List.unique?(["a", "b", "c"])
    end

    test "should return false if the list is not only composed of unique elements" do
      refute List.unique?(["a", "b", "c", "a"])
    end

    test "should return true if the list is empty" do
      assert List.unique?([])
    end
  end
end
