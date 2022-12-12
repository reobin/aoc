defmodule AoC.PointTest do
  use ExUnit.Case
  doctest AoC.Point

  alias AoC.Point

  describe "&Point.manhattan_distance/1" do
    test "should return the manhattan distance of a point" do
      assert Point.manhattan_distance({2, 2}) == 4
    end

    test "should return the manhattan distance of a point with negative coordinates" do
      assert Point.manhattan_distance({-2, 2}) == 4
    end
  end

  describe "&Point.between/2" do
    test "should return point for two equal points" do
      assert Point.between({2, 2}, {2, 2}) == []
    end

    test "should include source and destination if inclusive? option is activated" do
      assert Point.between({2, 2}, {2, 2}, inclusive?: true) == [{2, 2}, {2, 2}]
    end

    test "should return points for one unit distance points" do
      assert Point.between({2, 2}, {3, 2}) == []
      assert Point.between({2, 2}, {2, 3}) == []
      assert Point.between({2, 2}, {3, 3}) == []
      assert Point.between({2, 2}, {3, 100}) == []
    end

    test "should return points between two horizontally aligned points" do
      assert Point.between({0, 2}, {4, 2}) == [{1, 2}, {2, 2}, {3, 2}]
    end

    test "should return points between two vertically aligned points" do
      assert Point.between({2, 2}, {2, 5}) == [{2, 3}, {2, 4}]
    end

    test "should return points between two diagonally aligned points" do
      assert Point.between({2, 2}, {5, 5}) == [{3, 3}, {4, 4}]
    end

    test "should return points between two non diagonally aligned points" do
      assert Point.between({1, 1}, {7, 13}) == [{2, 3}, {3, 5}, {4, 7}, {5, 9}, {6, 11}]
    end

    test "should return no points with no alignment" do
      assert Point.between({0, 0}, {3, 4}) == []
      assert Point.between({4, 3}, {0, 0}) == []
      assert Point.between({3, 4}, {0, 0}) == []
    end
  end

  describe "&Point.distance/2" do
    test "should return 0 for two equal points" do
      assert Point.distance({2, 2}, {2, 2}) == 0
    end

    test "should return 1 for one unit distance points" do
      assert Point.distance({2, 2}, {3, 2}) == 1
      assert Point.distance({2, 2}, {2, 3}) == 1
    end

    test "should return 4 for two horizontally aligned points" do
      assert Point.distance({0, 2}, {4, 2}) == 4
    end

    test "should return diagonal distance for two diagonally aligned points" do
      assert Point.distance({2, 2}, {3, 3}) == 1.4142135623730951
    end
  end

  describe "&Point.share_axis?/2" do
    test "should return true for two equal points" do
      assert Point.share_axis?({2, 2}, {2, 2})
    end

    test "should return true for one unit distance points" do
      assert Point.share_axis?({2, 2}, {3, 2})
      assert Point.share_axis?({2, 2}, {2, 3})
    end

    test "should return true for two horizontally aligned points" do
      assert Point.share_axis?({0, 2}, {4, 2})
    end

    test "should return true for two vertically aligned points" do
      assert Point.share_axis?({2, 2}, {2, 5})
    end

    test "should return false for two diagonally aligned points" do
      refute Point.share_axis?({2, 2}, {5, 5})
    end
  end
end
