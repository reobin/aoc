defmodule AoC.Modules.PointTest do
  use ExUnit.Case
  doctest AoC.Modules.Point

  alias AoC.Modules.Point

  describe "&get_line/2" do
    test "should return all points for vertical line" do
      assert Point.get_line({1, 3}, {1, 1}) == [{1, 3}, {1, 2}, {1, 1}]
      assert Point.get_line({1, 1}, {1, 3}) == [{1, 1}, {1, 2}, {1, 3}]
    end

    test "should return all points for horizontal line" do
      assert Point.get_line({1, 1}, {3, 1}) == [{1, 1}, {2, 1}, {3, 1}]
      assert Point.get_line({3, 1}, {1, 1}) == [{3, 1}, {2, 1}, {1, 1}]
    end

    test "should return all points for diagonal line" do
      assert Point.get_line({1, 1}, {3, 3}) == [{1, 1}, {2, 2}, {3, 3}]
      assert Point.get_line({9, 7}, {7, 9}) == [{9, 7}, {8, 8}, {7, 9}]
      assert Point.get_line({3, 0}, {0, 3}) == [{3, 0}, {2, 1}, {1, 2}, {0, 3}]
    end
  end

  describe "&get_neighbors/1" do
    test "should return all straight neighbors with no options" do
      assert Point.get_neighbors({1, 1}) == [{1, 0}, {2, 1}, {1, 2}, {0, 1}]
    end

    test "should return all neighbors with option 8" do
      assert Point.get_neighbors({1, 1}, 8) == [
               {1, 0},
               {2, 0},
               {2, 1},
               {2, 2},
               {1, 2},
               {0, 2},
               {0, 1},
               {0, 0}
             ]
    end
  end
end
