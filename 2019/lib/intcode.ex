defmodule AoC.Intcode do
  @add 1
  @multiply 2
  @halt 99

  def parse_initial_program(input),
    do:
      input
      |> String.replace("\n", "")
      |> String.split(",", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {value, index}, program ->
        Map.put(program, index, String.to_integer(value))
      end)

  def run(program) do
    0..Enum.count(program)
    |> Enum.reduce_while(
      %{program: program, index: 0},
      fn _index, state ->
        execute(state, state.program[state.index])
      end
    )
    |> Map.get(:program)
  end

  def programs_equal?(program_a, program_b) do
    Enum.count(program_a) == Enum.count(program_b) and
      0..Enum.count(program_a)
      |> Enum.to_list()
      |> Enum.all?(fn index -> program_a[index] == program_b[index] end)
  end

  defp execute(state, nil), do: {:halt, state}

  defp execute(%{program: program, index: index}, @add) do
    sum =
      [program[index + 1], program[index + 2]]
      |> Enum.map(fn index -> program[index] end)
      |> Enum.sum()

    next_index = index + 3
    {:cont, %{program: program |> Map.put(program[next_index], sum), index: next_index}}
  end

  defp execute(%{program: program, index: index}, @multiply) do
    product =
      [program[index + 1], program[index + 2]]
      |> Enum.map(fn index -> program[index] end)
      |> Enum.reduce(1, fn factor, product -> factor * product end)

    next_index = index + 3
    {:cont, %{program: program |> Map.put(program[next_index], product), index: next_index}}
  end

  defp execute(state, @halt) do
    {:halt, state}
  end

  defp execute(%{program: program, index: index}, _opcode) do
    {:cont, %{program: program, index: index + 1}}
  end
end
