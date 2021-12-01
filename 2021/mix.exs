defmodule AoC.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc,
      version: "1.0.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: [],
      aliases: aliases()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp aliases do
    [
      "aoc.create": "run bin/create.exs",
      "aoc.remove": "run bin/remove.exs",
      "aoc.start": "run bin/start.exs",
      "aoc.benchmark": "run bin/benchmark.exs"
    ]
  end
end
