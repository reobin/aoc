day = AoC.System.get_day()

module_file_path = "lib/#{day}.ex"
script_file_path = "day/#{day}.exs"
test_file_path = "test/#{day}_test.exs"
input_file_path = "input/#{day}.txt"

[module_file_path, script_file_path, test_file_path, input_file_path]
|> Enum.each(&File.rm/1)
