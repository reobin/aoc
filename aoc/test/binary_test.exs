defmodule AoC.Modules.BinaryTest do
  use ExUnit.Case
  doctest AoC.Binary

  alias AoC.Binary

  describe "&to_decimal/1" do
    test "should return decimal representation of binary value" do
      assert Binary.to_decimal("110101") == 53
    end
  end

  describe "&from_decimal/1" do
    test "should return binary representation of decimal value" do
      assert Binary.from_decimal(53) == "110101"
    end
  end

  describe "&get_max_decimal_value/1" do
    test "should return maximal decimal value of a limited bit binary" do
      max_decimal_value = Binary.to_decimal("11111")
      assert Binary.get_max_decimal_value(5) == max_decimal_value
    end
  end

  describe "&invert/1" do
    test "should invert all bits of a binary value" do
      assert Binary.invert("110101") == "1010"
      assert Binary.invert("001010") == "110101"
    end
  end
end
