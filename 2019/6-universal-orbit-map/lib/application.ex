defmodule Orbit.Application do
  use Application

  def start(_type, _args) do
    # path = "./input.txt"
    # input = Orbit.get_input(path)
    # orbits = Orbit.get_orbits(input)
    # orbits_count = Orbit.count_orbits(orbits)
    # IO.puts(orbits_count)

    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
