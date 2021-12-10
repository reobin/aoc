defmodule AoC.Modules.IntcodeTest do
  use ExUnit.Case
  doctest AoC.Modules.Intcode

  alias AoC.Modules.Intcode

  describe "&get_program/1" do
    test "should return list of instuctions" do
      input = "1,9,10,3,2,3,11,0,99,30,40,50"

      program = Intcode.get_program(input)

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
      program = %{
        0 => 1,
        1 => 1,
        2 => 1,
        3 => 0,
        4 => 99
      }

      program = program |> Intcode.run()

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

      assert program == expected_program
    end

    test "should halt the program at halt instruction" do
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

      assert program == expected_program
    end

    test "should allow immediate parameter mode" do
      program = %{
        0 => 101,
        1 => 10,
        2 => 1,
        3 => 0,
        4 => 99
      }

      program = program |> Intcode.run()

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
      program = %{
        0 => 3,
        1 => 3,
        2 => 1102,
        3 => 4,
        4 => 3,
        5 => 0,
        6 => 4,
        7 => 0
      }

      assert Intcode.run(program, 1) == 3
    end

    test "should run output instruction" do
      program = %{
        0 => 1102,
        1 => 4,
        2 => 3,
        3 => 0,
        4 => 4,
        5 => 0
      }

      assert Intcode.run(program) == 12
    end

    test "should run jump_if_true instruction" do
      program = %{
        0 => 1105,
        1 => 1,
        2 => 5,
        3 => 104,
        4 => 100,
        5 => 104,
        6 => 200
      }

      assert Intcode.run(program) == 200

      program = %{
        0 => 1105,
        1 => 0,
        2 => 3,
        3 => 104,
        4 => 100,
        5 => 104,
        6 => 200
      }

      assert Intcode.run(program) == 100
    end

    test "should run jump_if_false instruction" do
      program = %{
        0 => 1106,
        1 => 0,
        2 => 5,
        3 => 104,
        4 => 100,
        5 => 104,
        6 => 200
      }

      assert Intcode.run(program) == 200

      program = %{
        0 => 1106,
        1 => 1,
        2 => 3,
        3 => 104,
        4 => 100,
        5 => 104,
        6 => 200
      }

      assert Intcode.run(program) == 100
    end

    test "should run less_than instruction" do
      program = %{
        0 => 1107,
        1 => 1,
        2 => 2,
        3 => 5,
        4 => 104,
        5 => 999,
      }

      assert Intcode.run(program) == 1

      program = %{
        0 => 1107,
        1 => 2,
        2 => 1,
        3 => 5,
        4 => 4,
        5 => 999,
      }

      assert Intcode.run(program) == 1107
    end

    test "should run equals instruction" do
      program = %{
        0 => 1108,
        1 => 2,
        2 => 2,
        3 => 5,
        4 => 104,
        5 => 999,
      }

      assert Intcode.run(program) == 1

      program = %{
        0 => 1108,
        1 => 2,
        2 => 1,
        3 => 5,
        4 => 4,
        5 => 999,
      }

      assert Intcode.run(program) == 1108
    end

    test "should run series of instructions" do
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

      assert program == expected_program
    end
  end
end
