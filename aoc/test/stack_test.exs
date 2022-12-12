defmodule AoC.StackTest do
  use ExUnit.Case
  doctest AoC.Stack

  alias AoC.Stack

  describe "&pop/1" do
    test "should return the new stack and top" do
      assert Stack.pop([1, 2, 3]) == {1, [2, 3]}
    end

    test "should return first items when a count is specified" do
      assert Stack.pop([1, 2, 3], 2) == {[1, 2], [3]}
    end

    test "should return nil if the stack is empty" do
      assert Stack.pop([]) == {nil, []}
    end
  end

  describe "&push/1" do
    test "should add an item on top of the stack" do
      assert Stack.push([], 1) == [1]
    end

    test "should add many items on top of the stack" do
      assert Stack.push([], [1, 2]) == [1, 2]
    end
  end

  describe "&top/1" do
    test "should return the first item of a stack" do
      assert Stack.top([1, 2, 3]) == 1
    end

    test "should return nil if the stack is empty" do
      assert [] |> Stack.top() |> is_nil()
    end
  end
end
