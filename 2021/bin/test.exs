# Runs the code for a specific day challenge

day = AoC.System.get_day()

if is_nil(day) do
  raise "Please provide a day: mix aoc.test 12"
  exit(1)
end

System.cmd("mix", ["test", "test/#{day}_test.exs"])

ExUnit.start()
