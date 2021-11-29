# Runs the code for a specific day challenge

day = AoC.System.get_day()

if is_nil(day) do
  raise "Please provide a day: mix aoc.start 12"
  exit(1)
end

module = String.to_existing_atom("Elixir.AoC.Day#{day}")

input = File.read!("input/day_#{day}.txt")

input |> module.part_1() |> IO.puts()
input |> module.part_2() |> IO.puts()
