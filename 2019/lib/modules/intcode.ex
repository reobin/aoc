defmodule AoC.Modules.Intcode do
  @moduledoc """
  Module for the Intcode computer
  """

  @add 1
  @multiply 2
  @halt 99

  @doc """
  Reads input and return a list of integers
  """
  def get_program(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {value, address}, program -> Map.put(program, address, value) end)
  end

  @doc """
  Runs a intcode program
  """
  def run(program) do
    program
    |> Map.values()
    |> Enum.reduce_while({program, 0}, fn _value, {program, instruction_pointer} = state ->
      execute(state, Map.get(program, instruction_pointer))
    end)
    |> elem(0)
  end

  defp execute(state, nil), do: {:halt, state}
  defp execute(state, @halt), do: {:halt, state}

  defp execute({program, address}, @add) do
    input_a = program |> Map.get(address + 1) |> then(&Map.get(program, &1))
    input_b = program |> Map.get(address + 2) |> then(&Map.get(program, &1))

    output = program |> Map.get(address + 3)

    program = Map.put(program, output, input_a + input_b)

    {:cont, {program, address + 4}}
  end

  defp execute({program, address}, @multiply) do
    input_a = program |> Map.get(address + 1) |> then(&Map.get(program, &1))
    input_b = program |> Map.get(address + 2) |> then(&Map.get(program, &1))

    output = program |> Map.get(address + 3)

    program = Map.put(program, output, input_a * input_b)

    {:cont, {program, address + 4}}
  end
end
