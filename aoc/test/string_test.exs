defmodule AoC.StringTest do
  use ExUnit.Case
  doctest AoC.String

  alias AoC.String

  describe "&lower_case?/1" do
    test "should return if string is lower cased" do
      assert String.lower_case?("abcde")
      assert String.lower_case?("a")

      refute String.lower_case?("abcDe")
      refute String.lower_case?("A")
    end
  end

  describe "&character_frequencies/1" do
    test "should return frequency for each character" do
      assert String.character_frequencies("abcdeab") == %{
               "a" => 2,
               "b" => 2,
               "c" => 1,
               "d" => 1,
               "e" => 1
             }
    end
  end

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
