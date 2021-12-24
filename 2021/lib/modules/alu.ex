defmodule AoC.Modules.ALU do
  @moduledoc """
  ALU Program
  """

  @doc """
  Runs ALU instructions on a program
  """
  def run(program, input \\ []) do
    program = Map.put(program, :input, input)
    program |> Map.get(:instructions, []) |> Enum.reduce(program, &execute/2)
  end

  defp execute({"inp", [a]}, %{input: input} = state),
    do: state |> Map.put(a, Enum.at(input, 0)) |> Map.put(:input, Enum.slice(input, 1..-1))

  defp execute({"add", [a, b]}, state), do: operate(a, b, state, &+/2)
  defp execute({"mul", [a, b]}, state), do: operate(a, b, state, &*/2)
  defp execute({"div", [a, b]}, state), do: operate(a, b, state, &trunc(&1 / &2))
  defp execute({"mod", [a, b]}, state), do: operate(a, b, state, &rem/2)
  defp execute({"eql", [a, b]}, state), do: compare(a, b, state, &==/2)

  defp operate(a, b, state, op) when is_atom(b), do: operate(a, Map.get(state, b), state, op)
  defp operate(a, b, state, op), do: Map.put(state, a, op.(Map.get(state, a), b))

  defp compare(a, b, state, cmp) when is_atom(b), do: compare(a, Map.get(state, b), state, cmp)
  defp compare(a, b, state, cmp), do: Map.put(state, a, (cmp.(Map.get(state, a), b) && 1) || 0)

  @doc """
  Parses an input and return the instructions for an ALU program
  """
  def initialize(input) do
    instructions =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [instruction | parameters] = String.split(line, " ", trim: true)

        parameters =
          Enum.map(parameters, fn value ->
            try do
              String.to_integer(value)
            rescue
              _ -> String.to_atom(value)
            end
          end)

        {instruction, parameters}
      end)

    %{instructions: instructions, w: 0, x: 0, y: 0, z: 0}
  end
end
