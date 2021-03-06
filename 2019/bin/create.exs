day = AoC.System.get_day()

IO.puts("Creating files for day #{day}")

module_file_path = "lib/#{day}.ex"
script_file_path = "day/#{day}.exs"
test_file_path = "test/#{day}_test.exs"
input_file_path = "input/#{day}.txt"

[module_file_path, script_file_path, test_file_path, input_file_path]
|> Enum.each(fn path ->
  if File.exists?(path), do: exit("#{path} exists")
end)

# Create module file
module_file_content = """
defmodule AoC.Day#{day} do
  def part_1(input) do
    IO.inspect(input)
    "part 1"
  end

  def part_2(input) do
    IO.inspect(input)
    "part 2"
  end
end
"""

{:ok} = AoC.System.write(module_file_path, module_file_content)

# Create day module file
script_file_content = """
input = File.read!("#{input_file_path}")

IO.puts(AoC.Day#{day}.part_1(input))
IO.puts(AoC.Day#{day}.part_2(input))
"""

{:ok} = AoC.System.write(script_file_path, script_file_content)

test_file_content = """
defmodule AoC.Day#{day}Test do
  use ExUnit.Case
  doctest AoC.Day#{day}

  test "part 1" do
    input = "test input"
    assert AoC.Day#{day}.part_1(input) == "part 1"
  end

  test "part 2" do
    input = "test input"
    assert AoC.Day#{day}.part_2(input) == "part 2"
  end
end
"""

{:ok} = AoC.System.write(test_file_path, test_file_content)

{:ok} = AoC.System.write(input_file_path, "")
