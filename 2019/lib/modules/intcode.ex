defmodule AoC.Modules.Intcode do
  @moduledoc """
  Module for the Intcode computer
  """

  @add 1
  @multiply 2
  @input 3
  @output 4
  @jump_if_true 5
  @jump_if_false 6
  @less_than 7
  @equals 8
  @relative_base_offset 9
  @halt 99

  @position_mode 0
  @immediate_mode 1
  @relative_mode 2

  @doc """
  Initializes the state of a intcode program
  """
  def initialize(instructions) do
    %{program: parse_instructions(instructions), instruction_pointer: 0, relative_base: 0}
  end

  defp parse_instructions(instructions) do
    instructions
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {value, address}, program -> Map.put(program, address, value) end)
  end

  @doc """
  Runs a intcode program
  """
  def run(state, input \\ []),
    do: state |> Map.put(:input, input) |> then(&run_while({:cont, &1}))

  defp run_while({:cont, state}) do
    {opcode, parameter_modes} = get_instruction(state)
    state = Map.put(state, :parameter_modes, parameter_modes)
    opcode |> execute(state) |> run_while()
  end

  defp run_while({:halt, state}), do: state

  defp get_instruction(%{program: program, instruction_pointer: instruction_pointer}) do
    [parameter_modes, opcode] =
      program
      |> Map.get(instruction_pointer)
      |> Integer.to_string()
      |> String.pad_leading(5, "0")
      |> String.split("", trim: true)
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.join(&1, ""))

    parameter_modes =
      parameter_modes
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()

    {String.to_integer(opcode), parameter_modes}
  end

  defp execute(nil, state), do: {:halt, Map.put(state, :output, :error)}
  defp execute(@halt, state), do: {:halt, Map.put(state, :output, :halt)}

  defp execute(@add, state) do
    %{
      program: program,
      parameter_modes: parameter_modes,
      instruction_pointer: instruction_pointer
    } = state

    parameter_a = get_parameter(state, instruction_pointer + 1, Enum.at(parameter_modes, 0))
    parameter_b = get_parameter(state, instruction_pointer + 2, Enum.at(parameter_modes, 1))

    parameter_c =
      get_parameter(state, instruction_pointer + 3, Enum.at(parameter_modes, 2), :write)

    program = Map.put(program, parameter_c, parameter_a + parameter_b)

    state = Map.merge(state, %{program: program, instruction_pointer: instruction_pointer + 4})

    {:cont, state}
  end

  defp execute(@multiply, state) do
    %{
      program: program,
      instruction_pointer: instruction_pointer,
      parameter_modes: parameter_modes
    } = state

    parameter_a = get_parameter(state, instruction_pointer + 1, Enum.at(parameter_modes, 0))
    parameter_b = get_parameter(state, instruction_pointer + 2, Enum.at(parameter_modes, 1))

    parameter_c =
      get_parameter(state, instruction_pointer + 3, Enum.at(parameter_modes, 2), :write)

    program = Map.put(program, parameter_c, parameter_a * parameter_b)

    state = Map.merge(state, %{program: program, instruction_pointer: instruction_pointer + 4})

    {:cont, state}
  end

  defp execute(@input, state) do
    %{
      program: program,
      instruction_pointer: instruction_pointer,
      input: input,
      parameter_modes: parameter_modes
    } = state

    current_input = Enum.at(input, 0)

    store = get_parameter(state, instruction_pointer + 1, Enum.at(parameter_modes, 0), :write)

    program = Map.put(program, store, current_input)

    state =
      Map.merge(state, %{
        program: program,
        instruction_pointer: instruction_pointer + 2,
        input: Enum.slice(input, 1..(Enum.count(input) - 1))
      })

    {:cont, state}
  end

  defp execute(@output, state) do
    %{instruction_pointer: instruction_pointer, parameter_modes: parameter_modes} = state

    output = get_parameter(state, instruction_pointer + 1, Enum.at(parameter_modes, 0))

    state = Map.merge(state, %{instruction_pointer: instruction_pointer + 2, output: output})

    {:halt, state}
  end

  defp execute(@jump_if_true, state) do
    %{instruction_pointer: instruction_pointer, parameter_modes: parameter_modes} = state

    parameter_a = get_parameter(state, instruction_pointer + 1, Enum.at(parameter_modes, 0))
    parameter_b = get_parameter(state, instruction_pointer + 2, Enum.at(parameter_modes, 1))

    next_instruction_pointer = if parameter_a != 0, do: parameter_b, else: instruction_pointer + 3

    {:cont, Map.put(state, :instruction_pointer, next_instruction_pointer)}
  end

  defp execute(@jump_if_false, state) do
    %{instruction_pointer: instruction_pointer, parameter_modes: parameter_modes} = state

    parameter_a = get_parameter(state, instruction_pointer + 1, Enum.at(parameter_modes, 0))
    parameter_b = get_parameter(state, instruction_pointer + 2, Enum.at(parameter_modes, 1))

    next_instruction_pointer = if parameter_a == 0, do: parameter_b, else: instruction_pointer + 3

    {:cont, Map.put(state, :instruction_pointer, next_instruction_pointer)}
  end

  defp execute(@less_than, state) do
    %{
      program: program,
      instruction_pointer: instruction_pointer,
      parameter_modes: parameter_modes
    } = state

    parameter_a = get_parameter(state, instruction_pointer + 1, Enum.at(parameter_modes, 0))
    parameter_b = get_parameter(state, instruction_pointer + 2, Enum.at(parameter_modes, 1))

    parameter_c =
      get_parameter(state, instruction_pointer + 3, Enum.at(parameter_modes, 2), :write)

    value = if parameter_a < parameter_b, do: 1, else: 0

    state =
      Map.merge(state, %{
        program: Map.put(program, parameter_c, value),
        instruction_pointer: instruction_pointer + 4
      })

    {:cont, state}
  end

  defp execute(@equals, state) do
    %{
      program: program,
      instruction_pointer: instruction_pointer,
      parameter_modes: parameter_modes
    } = state

    parameter_a = get_parameter(state, instruction_pointer + 1, Enum.at(parameter_modes, 0))
    parameter_b = get_parameter(state, instruction_pointer + 2, Enum.at(parameter_modes, 1))

    parameter_c =
      get_parameter(state, instruction_pointer + 3, Enum.at(parameter_modes, 2), :write)

    value = if parameter_a == parameter_b, do: 1, else: 0

    state =
      Map.merge(state, %{
        program: Map.put(program, parameter_c, value),
        instruction_pointer: instruction_pointer + 4
      })

    {:cont, state}
  end

  defp execute(@relative_base_offset, state) do
    %{
      instruction_pointer: instruction_pointer,
      relative_base: relative_base,
      parameter_modes: parameter_modes
    } = state

    offset = get_parameter(state, instruction_pointer + 1, Enum.at(parameter_modes, 0))

    state =
      Map.merge(state, %{
        relative_base: relative_base + offset,
        instruction_pointer: instruction_pointer + 2
      })

    {:cont, state}
  end

  defp get_parameter(state, address, @relative_mode, :write),
    do: Map.get(state.program, address, 0) + state.relative_base

  defp get_parameter(state, address, _mode, :write), do: Map.get(state.program, address, 0)

  defp get_parameter(state, address, @position_mode) do
    value = Map.get(state.program, address)
    Map.get(state.program, value, 0)
  end

  defp get_parameter(state, address, @immediate_mode), do: Map.get(state.program, address, 0)

  defp get_parameter(state, address, @relative_mode) do
    value = Map.get(state.program, address)
    Map.get(state.program, value + state.relative_base, 0)
  end
end
