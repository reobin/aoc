defmodule AoC2022.Day07 do
  @moduledoc """
  https://adventofcode.com/2022/day/7
  """

  @max_size 100_000

  def part_1(input) do
    tree = input |> parse_commands() |> run()

    tree
    |> list_directories(:recursive)
    |> Enum.map(&size(&1, tree))
    |> Enum.filter(&(&1 <= @max_size))
    |> Enum.sum()
  end

  @total_size 70_000_000
  @size_needed 30_000_000

  def part_2(input) do
    tree = input |> parse_commands() |> run()
    directory_sizes = tree |> list_directories(:recursive) |> Enum.map(&size(&1, tree))
    size_used = Enum.max(directory_sizes)

    directory_sizes
    |> Enum.filter(fn size -> @total_size - (size_used - size) >= @size_needed end)
    |> Enum.min()
  end

  defp size(dir, tree) do
    sub_tree = Enum.reduce(dir, tree, &Map.get(&2, &1))
    sub_directories = list_directories(sub_tree)
    files_size = sub_tree |> Map.values() |> Enum.filter(&is_integer/1) |> Enum.sum()
    files_size + (sub_directories |> Enum.map(&size(&1, sub_tree)) |> Enum.sum())
  end

  defp run(commands), do: run(commands, %{}, [])
  defp run([], state, _current_dir), do: state

  defp run([{:ls, _dir, content} | commands], state, current_dir) do
    state = store(state, current_dir, content)
    run(commands, state, current_dir)
  end

  defp run([{:cd, dir, _} | commands], state, current_dir),
    do: run(commands, state, cd(current_dir, dir))

  defp store(_state, [], content),
    do: Enum.reduce(content, %{}, fn c, state -> Map.merge(state, c) end)

  defp store(state, [dir | rest], content) do
    child = store(Map.get(state, dir, %{}), rest, content)
    Map.put(state, dir, child)
  end

  defp cd(dir, ".."), do: Enum.slice(dir, 0..-2)
  defp cd(dir, d), do: dir ++ [d]

  defp list_directories(tree) do
    tree
    |> Map.keys()
    |> Enum.filter(fn key -> is_map(Map.get(tree, key)) end)
    |> Enum.map(fn key -> [key] end)
  end

  defp list_directories(tree, :recursive) do
    current = list_directories(tree)

    current ++
      Enum.reduce(current, [], fn [dir], acc ->
        acc ++
          Enum.map(list_directories(Map.get(tree, dir), :recursive), fn dirs -> [dir | dirs] end)
      end)
  end

  defp parse_commands(input),
    do: input |> String.split(~r/\n?\$ /, trim: true) |> Enum.map(&parse_command/1)

  defp parse_command(block) do
    [command | result] = String.split(block, "\n")
    [verb | args] = String.split(command, " ")
    result = parse_result(result)
    {String.to_atom(verb), Enum.at(args, 0), result}
  end

  defp parse_result(result) do
    result
    |> Enum.map(fn line ->
      [size, name] = String.split(line, " ")

      size =
        try do
          String.to_integer(size)
        rescue
          _ -> %{}
        end

      Map.put(%{}, name, size)
    end)
  end
end
