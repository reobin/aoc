defmodule AoC2021.ALUTest do
  use ExUnit.Case
  doctest AoC2021.ALU

  alias AoC2021.ALU

  describe "&initialize/1" do
    test "should return the list of instructions and the initial state" do
      input = "inp w
add z w
mod z 2
div w 2
add y w
mod y 2
div w 2
add x w
mod x 2
div w 2
mod w 2"

      assert ALU.initialize(input) == %{
               instructions: [
                 {"inp", [:w]},
                 {"add", [:z, :w]},
                 {"mod", [:z, 2]},
                 {"div", [:w, 2]},
                 {"add", [:y, :w]},
                 {"mod", [:y, 2]},
                 {"div", [:w, 2]},
                 {"add", [:x, :w]},
                 {"mod", [:x, 2]},
                 {"div", [:w, 2]},
                 {"mod", [:w, 2]}
               ],
               w: 0,
               x: 0,
               y: 0,
               z: 0
             }
    end
  end

  describe "&run/1" do
    test "should run a simple input program" do
      program = %{
        instructions: [{"inp", [:x]}, {"mul", [:x, -1]}],
        w: 0,
        x: 0,
        y: 0,
        z: 0
      }

      assert ALU.run(program, [5]).x == -5
    end

    test "should run a more complex program" do
      program = %{
        instructions: [
          {"inp", [:z]},
          {"inp", [:x]},
          {"mul", [:z, 3]},
          {"eql", [:z, :x]}
        ],
        w: 0,
        x: 0,
        y: 0,
        z: 0
      }

      assert ALU.run(program, [3, 9]).z == 1
      assert ALU.run(program, [3, 8]).z == 0
    end

    test "should run a binary converter program" do
      input = "inp w
add z w
mod z 2
div w 2
add y w
mod y 2
div w 2
add x w
mod x 2
div w 2
mod w 2"

      program = ALU.initialize(input)

      result = ALU.run(program, [12])

      IO.inspect(result)

      assert result.z == 0
      assert result.y == 0
      assert result.x == 1
      assert result.w == 1
    end
  end
end
