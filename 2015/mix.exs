defmodule AoC.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc,
      version: "1.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: [],
      aliases: aliases()
    ]
  end

  def application do
    [extra_applications: [:logger, :crypto]]
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
