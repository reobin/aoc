# Runs a specific day challenge in order to benchmark its efficacity

day = AoC.System.get_day()

if is_nil(day) do
  raise "Please provide a day: mix aoc.benchmark 12"
  exit(1)
end

module = String.to_existing_atom("Elixir.AoC.Day#{day}")

input = File.read!("input/#{day}.txt")

execution_count = 1000

times =
  1..execution_count
  |> Enum.map(fn _index ->
    start_time = :os.system_time(:millisecond)

    module.part_1(input)
    module.part_2(input)

    end_time = :os.system_time(:millisecond)

    end_time - start_time
  end)

total_time = Enum.sum(times)

average_time = total_time / execution_count

IO.puts("Average execution time: #{average_time}ms")
