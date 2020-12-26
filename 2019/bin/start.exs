day = AoC.System.get_day()

{output, _} = System.cmd("mix", ["run", "day/#{day}.exs"])

IO.puts(output)
