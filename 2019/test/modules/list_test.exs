defmodule AoC.Modules.ListTest do
  use ExUnit.Case
  doctest AoC.Modules.List

  alias AoC.Modules.List

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
end
