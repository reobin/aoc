defmodule AoC.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end

  defp aliases do
    [
      create: "run bin/create.exs",
      delete: "run bin/delete.exs",
      start: "run bin/start.exs"
    ]
  end
end
