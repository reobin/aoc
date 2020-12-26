defmodule AoC do
  def version do
    {:ok, vsn} = :application.get_key(:aoc, :vsn)
    List.to_string(vsn)
  end
end
