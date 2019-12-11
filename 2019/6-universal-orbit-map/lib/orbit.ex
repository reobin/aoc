defmodule Orbit do
  def get_input(path) do
    File.stream!(path)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> Enum.join(",")
  end

  def get_orbits(input) do
    nodes = String.split(input, ",")

    Enum.map(nodes, fn node ->
      [parent_body | tail] = String.split(node, ")")
      satellite = Enum.join(tail)
      %{parent_body: parent_body, satellite: satellite}
    end)
  end

  def find_orbit(orbits, attr, by_parent_body \\ true),
    do:
      Enum.find(orbits, fn orbit ->
        if by_parent_body, do: orbit.parent_body == attr, else: orbit.satellite == attr
      end)

  def get_distance_to_origin(orbits, origin, orbit) do
    if orbit == origin do
      1
    else
      previous_orbit =
        Enum.find(orbits, fn o ->
          o.satellite == orbit.parent_body
        end)

      1 + get_distance_to_origin(orbits, origin, previous_orbit)
    end
  end

  def count_orbits(orbits) do
    origin = find_orbit(orbits, "COM")

    Enum.reduce(orbits, 0, fn orbit, acc ->
      acc + get_distance_to_origin(orbits, origin, orbit)
    end)
  end
end
