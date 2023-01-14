defmodule AoC.ListTest do
  use ExUnit.Case
  doctest AoC.List

  alias AoC.List

  describe "&intersection/1" do
    test "should find common elements between the lists" do
      assert List.intersection([["a", "b", "c"], ["b", "c", "d"]]) == ["b", "c"]
    end

    test "should return an empty list if there are no common elements" do
      assert List.intersection([["a", "b", "c"], ["d", "e", "f"]]) == []
    end
  end

  describe "&split/1" do
    test "should split the list into equal parts" do
      assert List.split(["a", "b", "c", "d", "e", "f"], 2) == [["a", "b", "c"], ["d", "e", "f"]]
    end

    test "should round down the number of parts" do
      assert List.split(["a", "b", "c", "d", "e", "f", "g"], 3) == [
               ["a", "b"],
               ["c", "d"],
               ["e", "f"],
               ["g"]
             ]
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

  describe "&pairs/1" do
    test "should return all possible unique pairs" do
      assert List.pairs([1, 2, 3]) == [[1, 2], [1, 3], [2, 3]]
      assert List.pairs(["abc", "def", "zyx"]) == [["abc", "def"], ["abc", "zyx"], ["def", "zyx"]]
    end
  end

  describe "&permutations/1" do
    test "should return all possible permutations" do
      list = [1, 2, 3]

      assert List.permutations(list) == [
               [1, 2, 3],
               [1, 3, 2],
               [2, 1, 3],
               [2, 3, 1],
               [3, 1, 2],
               [3, 2, 1]
             ]
    end
  end

  describe "&List.wrap_index/2" do
    test "should return the same index when in range" do
      assert List.wrap_index(1, [1, 2, 3]) == 1
      assert List.wrap_index(2, [1, 2, 3]) == 2
    end

    test "should return the computed index when negative" do
      assert List.wrap_index(-1, [1, 2, 3]) == 2
      assert List.wrap_index(-2, [1, 2, 3]) == 1
      assert List.wrap_index(-3, [1, 2, 3]) == 0
      assert List.wrap_index(-4, [1, 2, 3]) == 2
    end

    test "should return the computed index when out of range" do
      assert List.wrap_index(3, [1, 2, 3]) == 0
      assert List.wrap_index(4, [1, 2, 3]) == 1
      assert List.wrap_index(5, [1, 2, 3]) == 2
    end
  end
end
