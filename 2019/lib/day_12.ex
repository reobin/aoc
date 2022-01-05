defmodule AoC.Day12 do
  @moduledoc """
  https://adventofcode.com/2019/day/12
  """

  def part_1(input, steps \\ 1000) do
    moons = get_moons(input)

    1..steps
    |> Enum.reduce(moons, fn _step, moons -> simulate(moons) end)
    |> Enum.map(&compute_energy/1)
    |> Enum.sum()
  end

  defp compute_energy(%{position: {px, py, pz}, velocity: {vx, vy, vz}}),
    do: (abs(px) + abs(py) + abs(pz)) * (abs(vx) + abs(vy) + abs(vz))

  def part_2(input) do
    moons = get_moons(input)

    x = steps_to_stable(moons, 0)
    y = steps_to_stable(moons, 1)
    z = steps_to_stable(moons, 2)

    lcm(x, y, z)
  end

  defp steps_to_stable(moons, coordinate, step \\ 1) do
    moons = simulate(moons)

    cond do
      step == 1 -> steps_to_stable(moons, coordinate, step + 1)
      Enum.all?(moons, &(elem(&1.velocity, coordinate) == 0)) -> step * 2
      true -> steps_to_stable(moons, coordinate, step + 1)
    end
  end

  defp simulate(moons), do: moons |> apply_gravity() |> Enum.map(&apply_velocity/1)

  defp apply_gravity(moons),
    do: Enum.reduce(moons, [], fn moon, list -> [Enum.reduce(moons, moon, &pull/2) | list] end)

  defp pull(%{position: {px, py, pz}}, %{position: {mx, my, mz}, velocity: {vx, vy, vz}} = moon),
    do: Map.put(moon, :velocity, {adjust(mx, px, vx), adjust(my, py, vy), adjust(mz, pz, vz)})

  defp apply_velocity(%{position: {px, py, pz}, velocity: {vx, vy, vz}} = moon),
    do: Map.put(moon, :position, {px + vx, py + vy, pz + vz})

  defp adjust(m, m, v), do: v
  defp adjust(m, p, v) when m > p, do: v - 1
  defp adjust(m, p, v) when m < p, do: v + 1

  defp gcd(a, 0), do: abs(a)
  defp gcd(a, b), do: gcd(b, rem(a, b))

  defp lcm(a, b), do: div(abs(a * b), gcd(a, b))
  defp lcm(a, b, c), do: a |> lcm(b) |> lcm(c)

  defp get_moons(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.replace(&1, ~r/(<|>|\w=)/, ""))
    |> Enum.map(fn line ->
      line
      |> String.split(", ")
      |> Enum.map(&String.to_integer/1)
      |> then(fn [x, y, z] -> %{position: {x, y, z}, velocity: {0, 0, 0}} end)
    end)
  end
end
