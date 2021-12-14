defmodule AoC.Modules.PointTest do
  use ExUnit.Case
  doctest AoC.Modules.Point

  alias AoC.Modules.Point

  describe "&compute_manhattan_distance/1" do
    test "should return the manhattan distance of a point" do
      assert Point.compute_manhattan_distance({2, 2}) == 4
    end

    test "should return the manhattan distance of a point with negative coordinates" do
      assert Point.compute_manhattan_distance({-2, 2}) == 4
    end
  end

  describe "&get_between/2" do
    test "should return point for two equal points" do
      assert Point.get_between({2, 2}, {2, 2}) == []
    end

    test "should return points for one unit distance points" do
      assert Point.get_between({2, 2}, {3, 2}) == []
      assert Point.get_between({2, 2}, {2, 3}) == []
      assert Point.get_between({2, 2}, {3, 3}) == []
      assert Point.get_between({2, 2}, {3, 100}) == []
    end

    test "should return points between two horizontally aligned points" do
      assert Point.get_between({0, 2}, {4, 2}) == [{1, 2}, {2, 2}, {3, 2}]
    end

    test "should return points between two vertically aligned points" do
      assert Point.get_between({2, 2}, {2, 5}) == [{2, 3}, {2, 4}]
    end

    test "should return points between two diagonally aligned points" do
      assert Point.get_between({2, 2}, {5, 5}) == [{3, 3}, {4, 4}]
    end

    test "should return points between two non diagonally aligned points" do
      assert Point.get_between({1, 1}, {7, 13}) == [{2, 3}, {3, 5}, {4, 7}, {5, 9}, {6, 11}]
    end

    test "should return no points with no alignment" do
      assert Point.get_between({0, 0}, {3, 4}) == []
      assert Point.get_between({4, 3}, {0, 0}) == []
      assert Point.get_between({3, 4}, {0, 0}) == []
    end
  end
end
