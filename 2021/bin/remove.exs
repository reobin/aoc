# Removes all files for a specific day challenge

alias AoC.Modules.SystemCommand

day = SystemCommand.get_day()

if is_nil(day) do
  raise "Please provide a day: mix aoc.remove 12"
  exit(1)
end

module_file_path = "lib/day_#{day}.ex"
test_file_path = "test/day_#{day}_test.exs"
input_file_path = "input/day_#{day}.txt"

[module_file_path, test_file_path, input_file_path]
|> Enum.each(&File.rm/1)
