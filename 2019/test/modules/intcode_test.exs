defmodule AoC.Modules.IntcodeTest do
  use ExUnit.Case
  doctest AoC.Modules.Intcode
  alias AoC.Modules.Intcode

  describe "&initialize/1" do
    test "should the initial state for the input" do
      input = "1,9,10,3,2,3,11,0,99,30,40,50"

      program = Intcode.initialize(input) |> Map.get(:program)

      expected_program = %{
        0 => 1,
        1 => 9,
        2 => 10,
        3 => 3,
        4 => 2,
        5 => 3,
        6 => 11,
        7 => 0,
        8 => 99,
        9 => 30,
        10 => 40,
        11 => 50
      }

      assert program == expected_program
    end
  end

  describe "&run/1" do
    test "should run add instruction" do
      program = "1,1,1,0,99" |> Intcode.initialize() |> Intcode.run() |> Map.get(:program)

      expected_program = %{
        0 => 2,
        1 => 1,
        2 => 1,
        3 => 0,
        4 => 99
      }

      assert program == expected_program
    end

    test "should run multiply instruction" do
      program = "2,3,0,3,99" |> Intcode.initialize() |> Intcode.run() |> Map.get(:program)

      expected_program = %{
        0 => 2,
        1 => 3,
        2 => 0,
        3 => 6,
        4 => 99
      }

      assert program == expected_program
    end

    test "should halt the program at halt instruction" do
      program = "99,1,6,7,5,0,30,40" |> Intcode.initialize() |> Intcode.run() |> Map.get(:program)

      expected_program = %{
        0 => 99,
        1 => 1,
        2 => 6,
        3 => 7,
        4 => 5,
        5 => 0,
        6 => 30,
        7 => 40
      }

      assert program == expected_program
    end

    test "should allow immediate parameter mode" do
      program = "101,10,1,0,99" |> Intcode.initialize() |> Intcode.run() |> Map.get(:program)

      expected_program = %{
        0 => 20,
        1 => 10,
        2 => 1,
        3 => 0,
        4 => 99
      }

      assert program == expected_program
    end

    test "should run input instruction" do
      output =
        "3,3,1102,4,3,0,4,0" |> Intcode.initialize() |> Intcode.run([1]) |> Map.get(:output)

      assert output == 3
    end

    test "should run output instruction" do
      output = "1102,4,3,0,4,0" |> Intcode.initialize() |> Intcode.run() |> Map.get(:output)

      assert output == 12
    end

    test "should run jump_if_true instruction" do
      output =
        "1105,1,5,104,100,104,200" |> Intcode.initialize() |> Intcode.run() |> Map.get(:output)

      assert output == 200

      output =
        "1105,0,3,104,100,104,200" |> Intcode.initialize() |> Intcode.run() |> Map.get(:output)

      assert output == 100
    end

    test "should run jump_if_false instruction" do
      output =
        "1106,0,5,104,100,104,200" |> Intcode.initialize() |> Intcode.run() |> Map.get(:output)

      assert output == 200

      output =
        "1106,1,3,104,100,104,200" |> Intcode.initialize() |> Intcode.run() |> Map.get(:output)

      assert output == 100
    end

    test "should run less_than instruction" do
      output = "1107,1,2,5,104,999" |> Intcode.initialize() |> Intcode.run() |> Map.get(:output)

      assert output == 1

      output = "1107,2,1,5,4,999" |> Intcode.initialize() |> Intcode.run() |> Map.get(:output)

      assert output == 1107
    end

    test "should run equals instruction" do
      output = "1108,2,2,5,104,999" |> Intcode.initialize() |> Intcode.run() |> Map.get(:output)

      assert output == 1

      output = "1108,2,1,5,4,999" |> Intcode.initialize() |> Intcode.run() |> Map.get(:output)

      assert output == 1108
    end

    test "should run series of instructions" do
      program =
        "1,1,1,4,99,5,6,0,99" |> Intcode.initialize() |> Intcode.run() |> Map.get(:program)

      expected_program = %{
        0 => 30,
        1 => 1,
        2 => 1,
        3 => 4,
        4 => 2,
        5 => 5,
        6 => 6,
        7 => 0,
        8 => 99
      }

      assert program == expected_program
    end

    test "should allow big numbers" do
      input = "104,1125899906842624,99"

      assert input |> Intcode.initialize() |> Intcode.run() |> Map.get(:output) ==
               1_125_899_906_842_624

      input = "1102,34915192,34915192,7,4,7,99,0"

      assert input
             |> Intcode.initialize()
             |> Intcode.run()
             |> Map.get(:output)
             |> Integer.to_string()
             |> String.length() ==
               16
    end

    test "should run relative_base_offset instruction" do
      input = "109,-1,4,1,99"
      assert input |> Intcode.initialize() |> Intcode.run() |> Map.get(:output) == -1

      input = "109,-1,104,1,99"
      assert input |> Intcode.initialize() |> Intcode.run() |> Map.get(:output) == 1
    end

    test "should allow relative parameter mode" do
      input = "109,-1,204,1,99"
      assert input |> Intcode.initialize() |> Intcode.run() |> Map.get(:output) == 109
    end

    test "should allow negative relative parameter mode" do
      input = "109,1,9,2,204,-6,99"
      assert input |> Intcode.initialize() |> Intcode.run() |> Map.get(:output) == 204
    end

    test "should allow negative relative parameter mode for relative base offset instruction" do
      input = "109,1,209,-1,204,-106,99"
      assert input |> Intcode.initialize() |> Intcode.run() |> Map.get(:output) == 204
    end
  end
end
