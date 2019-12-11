defmodule OrbitTest do
  use ExUnit.Case

  doctest Orbit

  test "get input" do
  end

  test "orbits from inputs" do
    input = "COM)B,B)C,C)D,D)E,E)F,B)G,G)H,D)I,E)J,J)K,K)L"

    orbits = [
      %{satellite: "B", parent_body: "COM"},
      %{satellite: "C", parent_body: "B"},
      %{satellite: "D", parent_body: "C"},
      %{satellite: "E", parent_body: "D"},
      %{satellite: "F", parent_body: "E"},
      %{satellite: "G", parent_body: "B"},
      %{satellite: "H", parent_body: "G"},
      %{satellite: "I", parent_body: "D"},
      %{satellite: "J", parent_body: "E"},
      %{satellite: "K", parent_body: "J"},
      %{satellite: "L", parent_body: "K"}
    ]

    assert Orbit.get_orbits(input) == orbits
  end

  test "find orbit" do
    orbits = [
      %{satellite: "B", parent_body: "COM"},
      %{satellite: "C", parent_body: "B"},
      %{satellite: "D", parent_body: "C"},
      %{satellite: "E", parent_body: "D"},
      %{satellite: "F", parent_body: "E"},
      %{satellite: "G", parent_body: "B"},
      %{satellite: "H", parent_body: "G"},
      %{satellite: "I", parent_body: "D"},
      %{satellite: "J", parent_body: "E"},
      %{satellite: "K", parent_body: "J"},
      %{satellite: "L", parent_body: "K"}
    ]

    assert Orbit.find_orbit(orbits, "COM") == %{satellite: "B", parent_body: "COM"}
  end

  test "distance to origin" do
    orbits = [
      %{satellite: "B", parent_body: "COM"},
      %{satellite: "C", parent_body: "B"},
      %{satellite: "D", parent_body: "C"},
      %{satellite: "E", parent_body: "D"},
      %{satellite: "F", parent_body: "E"},
      %{satellite: "G", parent_body: "B"},
      %{satellite: "H", parent_body: "G"},
      %{satellite: "I", parent_body: "D"},
      %{satellite: "J", parent_body: "E"},
      %{satellite: "K", parent_body: "J"},
      %{satellite: "L", parent_body: "K"}
    ]

    origin = %{satellite: "B", parent_body: "COM"}

    assert Orbit.get_distance_to_origin(
             orbits,
             origin,
             %{satellite: "B", parent_body: "COM"}
           ) == 1

    assert Orbit.get_distance_to_origin(
             orbits,
             origin,
             %{satellite: "L", parent_body: "K"}
           ) == 7

    assert Orbit.get_distance_to_origin(
             orbits,
             origin,
             %{satellite: "H", parent_body: "G"}
           ) == 3
  end

  test "map of orbits" do
    orbits = [
      %{satellite: "B", parent_body: "COM"},
      %{satellite: "C", parent_body: "B"},
      %{satellite: "D", parent_body: "C"},
      %{satellite: "E", parent_body: "D"},
      %{satellite: "F", parent_body: "E"},
      %{satellite: "G", parent_body: "B"},
      %{satellite: "H", parent_body: "G"},
      %{satellite: "I", parent_body: "D"},
      %{satellite: "J", parent_body: "E"},
      %{satellite: "K", parent_body: "J"},
      %{satellite: "L", parent_body: "K"}
    ]

    assert Orbit.count_orbits(orbits) == 42
  end
end
