defmodule AoC.Day02 do
  alias AoC.Intcode

  def part_1(input) do
    input |> Intcode.parse_initial_program() |> get_output(%{noun: 12, verb: 2})
  end

  def part_2(input) do
    %{noun: noun, verb: verb} =
      input
      |> Intcode.parse_initial_program()
      |> search_inputs(0..99, 19_690_720)

    100 * noun + verb
  end

  defp search_inputs(program, range, target) do
    for(noun <- range, verb <- range, do: %{noun: noun, verb: verb})
    |> Enum.find(fn values -> get_output(program, values) == target end)
  end

  defp get_output(program, %{noun: noun, verb: verb}) do
    program
    |> Map.put(1, noun)
    |> Map.put(2, verb)
    |> Intcode.run()
    |> Map.get(0)
  end
end
