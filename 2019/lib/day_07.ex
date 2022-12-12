defmodule AoC2019.Day07 do
  @moduledoc """
  https://adventofcode.com/2019/day/7
  """

  alias AoC2019.Modules.Intcode
  alias AoC.List

  def part_1(input) do
    state = Intcode.initialize(input)

    0..4
    |> Enum.to_list()
    |> List.permutations()
    |> Enum.map(&get_output_signal(state, &1, 0))
    |> Enum.max()
  end

  def part_2(input) do
    state = Intcode.initialize(input)

    5..9
    |> Enum.to_list()
    |> List.permutations()
    |> Enum.map(&get_output_signal(state, &1, 0, :feedback_loop))
    |> Enum.max()
  end

  defp get_output_signal(state, [a, b, c, d, e], input, :feedback_loop) do
    try do
      amp_a = Intcode.run(state, [a, input])
      amp_b = Intcode.run(state, [b, amp_a.output])
      amp_c = Intcode.run(state, [c, amp_b.output])
      amp_d = Intcode.run(state, [d, amp_c.output])
      amp_e = Intcode.run(state, [e, amp_d.output])

      1..1000
      |> Enum.reduce_while(
        [amp_a, amp_b, amp_c, amp_d, amp_e],
        fn _step, [amp_a, amp_b, amp_c, amp_d, amp_e] ->
          input = amp_e.output

          amp_a = Intcode.run(amp_a, [amp_e.output])
          amp_b = Intcode.run(amp_b, [amp_a.output])
          amp_c = Intcode.run(amp_c, [amp_b.output])
          amp_d = Intcode.run(amp_d, [amp_c.output])
          amp_e = Intcode.run(amp_e, [amp_d.output])

          if amp_e.output == :halt do
            {:halt, input}
          else
            {:cont, [amp_a, amp_b, amp_c, amp_d, amp_e]}
          end
        end
      )
    rescue
      _ -> 0
    end
  end

  defp get_output_signal(state, [a, b, c, d, e], input) do
    try do
      amp_a = Intcode.run(state, [a, input])
      amp_b = Intcode.run(state, [b, amp_a.output])
      amp_c = Intcode.run(state, [c, amp_b.output])
      amp_d = Intcode.run(state, [d, amp_c.output])
      state |> Intcode.run([e, amp_d.output]) |> Map.get(:output)
    rescue
      _ -> 0
    end
  end
end
