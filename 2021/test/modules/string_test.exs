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

  describe "&is_lower_case?/1" do
    test "should return if string is lower cased" do
      assert String.is_lower_case?("abcde") == true

      assert String.is_lower_case?("abcDe") == false

      assert String.is_lower_case?("a") == true

      assert String.is_lower_case?("A") == false
    end
  end

  describe "&get_character_frequencies/1" do
    test "should return frequency for each character" do
      assert String.get_character_frequencies("abcdeab") == %{
               "a" => 2,
               "b" => 2,
               "c" => 1,
               "d" => 1,
               "e" => 1
             }
    end
  end
end
