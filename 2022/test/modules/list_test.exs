defmodule AoC.Modules.ListTest do
  use ExUnit.Case
  doctest AoC.Modules.List

  alias AoC.Modules.List

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
end
