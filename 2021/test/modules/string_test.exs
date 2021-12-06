defmodule AoC.Modules.StringTest do
  use ExUnit.Case
  doctest AoC.Modules.String

  alias AoC.Modules.String

  describe "&count/1" do
    test "should return zero for an empty string" do
      assert String.count("", "z") == 0
    end

    test "should return zero if the character is not found" do
      assert String.count("abcda", "z") == 0
    end

    test "should return zero the characte count" do
      assert String.count("abcda", "a") == 2
    end
  end
end
