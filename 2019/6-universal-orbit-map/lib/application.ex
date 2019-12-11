defmodule Orbit.Application do
  use Application

  def round_1 do
    path = "./input.txt"
    input = Orbit.get_input(path)
    orbits = Orbit.get_orbits(input)
    orbits_count = Orbit.count_orbits(orbits)
    IO.puts(orbits_count)
  end

  def round_2 do
    path = "./input.txt"
    input = Orbit.get_input(path)
    orbits = Orbit.get_orbits(input)

    you = Orbit.find_orbit(orbits, "YOU", false)
    san = Orbit.find_orbit(orbits, "SAN", false)

    orbit_in_common = Orbit.get_orbit_in_common(orbits, you, san)

    distance_1 = Orbit.get_distance_to_origin(orbits, orbit_in_common, you)
    distance_2 = Orbit.get_distance_to_origin(orbits, orbit_in_common, san)

    distance = distance_1 + distance_2 - 4

    IO.puts(distance)
  end

  def start(_type, _args) do
    # IO.puts("round 1")
    # round_1()

    IO.puts("round 2")
    round_2()

    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
