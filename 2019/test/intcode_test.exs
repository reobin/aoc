defmodule AoC.IntcodeTest do
  use ExUnit.Case
  doctest AoC.Intcode

  alias AoC.Intcode

  describe "parse_initial_program" do
    test "should return list of opcode" do
      input = "1,9,10,3,2,3,11,0,99,30,40,50"

      program = Intcode.parse_initial_program(input)

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

      assert Enum.count(program) == Enum.count(expected_program)
      assert Intcode.programs_equal?(program, expected_program)
    end
  end

  describe "programs_equal?" do
    test "should return true if programs are equal" do
      program_a = %{
        0 => 1,
        1 => 9,
        2 => 10,
        3 => 3,
        4 => 2,
        5 => 3
      }

      program_b = %{
        0 => 1,
        1 => 9,
        2 => 10,
        3 => 3,
        4 => 2,
        5 => 3
      }

      assert Intcode.programs_equal?(program_a, program_b)
    end

    test "should return false if programs are of different length" do
      program_a = %{
        0 => 1,
        1 => 9,
        2 => 10,
        3 => 3,
        4 => 2
      }

      program_b = %{
        0 => 1,
        1 => 9,
        2 => 10,
        3 => 3,
        4 => 2,
        5 => 3
      }

      assert not Intcode.programs_equal?(program_a, program_b)
    end

    test "should return false if programs contain different values" do
      program_a = %{
        0 => 1,
        1 => 9,
        2 => 10,
        3 => 3,
        4 => 2,
        5 => 5
      }

      program_b = %{
        0 => 1,
        1 => 9,
        2 => 10,
        3 => 3,
        4 => 2,
        5 => 3
      }

      assert not Intcode.programs_equal?(program_a, program_b)
    end
  end

  describe "run" do
    test "should run add opcode" do
      program = %{
        0 => 1,
        1 => 0,
        2 => 0,
        3 => 0,
        4 => 99
      }

      program = program |> Intcode.run()

      expected_program = %{
        0 => 2,
        1 => 0,
        2 => 0,
        3 => 0,
        4 => 99
      }

      assert Enum.count(program) == Enum.count(expected_program)
      assert Intcode.programs_equal?(program, expected_program)
    end

    test "should run multiply opcode" do
      program = %{
        0 => 2,
        1 => 3,
        2 => 0,
        3 => 3,
        4 => 99
      }

      program = program |> Intcode.run()

      expected_program = %{
        0 => 2,
        1 => 3,
        2 => 0,
        3 => 6,
        4 => 99
      }

      assert Enum.count(program) == Enum.count(expected_program)
      assert Intcode.programs_equal?(program, expected_program)
    end

    test "should alt the program at alt opcode" do
      program = %{
        0 => 99,
        1 => 1,
        2 => 6,
        3 => 7,
        4 => 5,
        5 => 0,
        6 => 30,
        7 => 40
      }

      program = program |> Intcode.run()

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

      assert Enum.count(program) == Enum.count(expected_program)
      assert Intcode.programs_equal?(program, expected_program)
    end

    test "should run series of opcodes" do
      program = %{
        0 => 1,
        1 => 1,
        2 => 1,
        3 => 4,
        4 => 99,
        5 => 5,
        6 => 6,
        7 => 0,
        8 => 99
      }

      program = program |> Intcode.run()

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

      assert Enum.count(program) == Enum.count(expected_program)
      assert Intcode.programs_equal?(program, expected_program)
    end
  end
end
