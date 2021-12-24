defmodule AoC.Day24 do
  @moduledoc """
  https://adventofcode.com/2021/day/24

  By reverse engineering the MONAD program and inferring relationships between
  digits, the range of possible values for a model number are determined to
  respect these rules:

      d4 - 2 ==  d5
      d1 - 3 ==  d6
      d9 + 5 == d10
      d8 - 5 == d11
      d7 + 4 == d12
      d0 - 1 == d13

  By these rules, the only possible valid model numbers respect these ranges:

       d0: 2..9
       d1: 4..9
       d2: 9
       d3: 1
       d4: 3..9
       d5: 1..7
       d6: 1..6
       d7: 1..5
       d8: 6..9
       d9: 1..4
      d10: 6..9
      d11: 1..4
      d12: 5..9
      d13: 1..8

  Taking the minimum (part 2) and maximum (part 1) of each of the ranges to
  build the model number, both smallest and biggest valid model number are found.
  """

  alias AoC.Modules.ALU

  def part_1(input) do
    model_number = 99_919_765_949_498

    assert_valid(model_number, input)

    model_number
  end

  def part_2(input) do
    model_number = 24_913_111_616_151

    assert_valid(model_number, input)

    model_number
  end

  defp assert_valid(model_number, input) do
    program = ALU.initialize(input)

    alu_input = convert_to_input(model_number)

    if ALU.run(program, alu_input).z != 0 do
      throw(Error)
    end
  end

  defp convert_to_input(n),
    do: n |> Integer.to_string() |> String.split("", trim: true) |> Enum.map(&String.to_integer/1)
end
