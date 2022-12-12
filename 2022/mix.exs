defmodule AoC2022.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_2022,
      version: "1.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:aoc, path: "../aoc"}]
  end

  defp aliases do
    [
      "aoc.create": "run bin/create",
      "aoc.remove": "run bin/remove",
      "aoc.start": "run bin/start",
      "aoc.benchmark": "run bin/benchmark"
    ]
  end
end
