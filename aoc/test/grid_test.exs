defmodule AoC.GridTest do
  use ExUnit.Case
  doctest AoC.Grid

  alias AoC.Grid

  describe "&from_string/1" do
    test "should return null when given null" do
      assert nil |> Grid.from_string() |> is_nil()
    end

    test "should return null when given an empty string" do
      assert "" |> Grid.from_string() |> is_nil()
    end

    test "should build a grid given a 2D string value" do
      value = "111
556"

      expected_grid = %{
        {0, 0} => "1",
        {1, 0} => "1",
        {2, 0} => "1",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.from_string(value) == expected_grid
    end

    test "should allow different dividers" do
      value = "12:13:14|5:5:6"

      expected_grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.from_string(value, row_divider: "|", column_divider: ":") == expected_grid
    end
  end

  describe "&to_string/1" do
    test "should return empty string when grid is null" do
      assert Grid.to_string(nil) == ""
    end

    test "should return string representation of a grid" do
      grid = %{
        {0, 0} => "1",
        {1, 0} => "1",
        {2, 0} => "1",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      expected_string = "111
556"

      assert Grid.to_string(grid) == expected_string
    end

    test "should allow different dividers" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      expected_string = "12:13:14|5:5:6"

      assert Grid.to_string(grid, row_divider: "|", column_divider: ":", cell_width: 1) ==
               expected_string
    end
  end

  describe "&points/1" do
    test "should return empty array with null grid" do
      assert Grid.points(nil) == []
    end

    test "should return empty array with empty grid" do
      assert Grid.points(%{}) == []
    end

    test "should return all grid points" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert grid |> Grid.points() |> Enum.sort() ==
               [{0, 0}, {1, 0}, {2, 0}, {0, 1}, {1, 1}, {2, 1}] |> Enum.sort()
    end
  end

  describe "&values/1" do
    test "should return empty array with null grid" do
      assert Grid.values(nil) == []
    end

    test "should return empty array with empty grid" do
      assert Grid.values(%{}) == []
    end

    test "should return all grid points" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert grid |> Grid.values() |> Enum.sort() ==
               ["12", "13", "14", "5", "5", "6"] |> Enum.sort()
    end
  end

  describe "&get/2" do
    test "should return null with null grid" do
      assert nil |> Grid.get({0, 0}) |> is_nil()
    end

    test "should return null with empty grid" do
      assert %{} |> Grid.get({0, 0}) |> is_nil()
    end

    test "should return null with non existing point" do
      assert %{{0, 0} => "1"} |> Grid.get({1, 1}) |> is_nil()
    end

    test "should return value at point" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.get(grid, {0, 0}) == "12"
      assert Grid.get(grid, {1, 1}) == "5"
    end
  end

  describe "&size/1" do
    test "should return size zero with null grid" do
      assert Grid.size(nil) == {0, 0}
    end

    test "should return size zero with empty grid" do
      assert Grid.size(%{}) == {0, 0}
    end

    test "should return size of 2D grid" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.size(grid) == {3, 2}
    end
  end

  describe "&find/2" do
    test "should return null with null grid" do
      assert nil |> Grid.find("1") |> is_nil()
    end

    test "should return null with empty grid" do
      assert %{} |> Grid.find("1") |> is_nil()
    end

    test "should return null if value is not in grid" do
      assert %{{0, 0} => "1"} |> Grid.find("2") |> is_nil()
    end

    test "should return point if value is found" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.find(grid, "14") == {2, 0}
    end
  end

  describe "&rows/1" do
    test "should return empty array with null grid" do
      assert Grid.rows(nil) == []
    end

    test "should return empty array with empty grid" do
      assert Grid.rows(%{}) == []
    end

    test "should return rows on valid grid" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.rows(grid) == [["12", "13", "14"], ["5", "5", "6"]]
    end
  end

  describe "&columns/1" do
    test "should return empty array with null grid" do
      assert Grid.columns(nil) == []
    end

    test "should return empty array with empty grid" do
      assert Grid.columns(%{}) == []
    end

    test "should return rows on valid grid" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.columns(grid) == [["12", "5"], ["13", "5"], ["14", "6"]]
    end
  end

  describe "&set/3" do
    test "should update the value at the point" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      expected_grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "10",
        {2, 1} => "6"
      }

      assert Grid.set(grid, {1, 1}, "10") == expected_grid
    end
  end

  describe "&replace/3" do
    test "should return the same grid if the value is not found" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.replace(grid, "100", "10") == grid
    end

    test "should update the value at if the value is found" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      expected_grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "10",
        {0, 1} => "5",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.replace(grid, "14", "10") == expected_grid
    end

    test "should allow replacement of all matching values" do
      grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "14",
        {0, 1} => "14",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      expected_grid = %{
        {0, 0} => "12",
        {1, 0} => "13",
        {2, 0} => "10",
        {0, 1} => "10",
        {1, 1} => "5",
        {2, 1} => "6"
      }

      assert Grid.replace(grid, "14", "10") == expected_grid
    end
  end

  describe "&expand/2" do
    test "should expand grid with the same values" do
      input = "10
01"

      grid = Grid.from_string(input)

      expanded_grid = Grid.expand(grid, 2, 2)

      input = "1010
0101
1010
0101"
      expected_grid = Grid.from_string(input)

      assert expanded_grid == expected_grid
    end

    test "should expand grid with the same values of a bigger grid" do
      input = "101001101001
011010011010
101001101001
011010011010"

      grid = Grid.from_string(input)

      expanded_grid = Grid.expand(grid, 3, 1)

      input = "101001101001101001101001101001101001
011010011010011010011010011010011010
101001101001101001101001101001101001
011010011010011010011010011010011010"

      expected_grid = Grid.from_string(input)

      assert expanded_grid == expected_grid
    end

    test "should expand grid with a value modifier" do
      input = "10
01"

      grid = Grid.from_string(input, integer?: true)

      expanded_grid = Grid.expand(grid, 2, 2, fn cell, {dx, dy} -> cell + dx + dy end)

      input = "1021
0112
2132
1223"
      expected_grid = Grid.from_string(input, integer?: true)

      assert expanded_grid == expected_grid
    end

    test "should expand grid with a value modifier with a bigger grid" do
      input = "101001101001
011010011010
101001101001
011010011010"

      grid = Grid.from_string(input, integer?: true)

      expanded_grid = Grid.expand(grid, 3, 1, fn cell, {dx, dy} -> cell + dx + dy end)

      input = "101001101001212112212112323223323223
011010011010122121122121233232233232
101001101001212112212112323223323223
011010011010122121122121233232233232"

      expected_grid = Grid.from_string(input, integer?: true)

      assert expanded_grid == expected_grid
    end
  end

  describe "&add_layer/2" do
    test "should add layer around grid" do
      input = "1010
0110
1010
0110"

      layered_grid =
        input |> Grid.from_string(integer?: true) |> Grid.add_layer(3) |> Grid.to_string()

      input = "333333
310103
301103
310103
301103
333333"

      expected_grid = input |> Grid.from_string(integer?: true) |> Grid.to_string()

      assert layered_grid == expected_grid
    end
  end

  describe "Grid.shortest_path/3" do
    test "should find the shortest path" do
      input = "xxxx
xxxx
xxxx
xxxx"

      grid = Grid.from_string(input)

      assert Grid.shortest_path(grid, {0, 0}, {2, 2}) == 4
    end

    test "should take into account the can_move? option" do
      input = "sxxx
sxxx
sxsx
sssx"

      grid = Grid.from_string(input)

      can_move? = fn map, _from, to -> Grid.get(map, to) == "s" end
      assert Grid.shortest_path(grid, {0, 0}, {2, 2}, can_move?: can_move?) == 6
    end

    test "should take into account the cost option" do
      input = "0003
1444
0415
0016"

      grid = Grid.from_string(input, integer?: true)

      cost = fn map, point -> Grid.get(map, point) end
      assert Grid.shortest_path(grid, {0, 0}, {2, 2}, cost: cost) == 3
    end
  end
end
