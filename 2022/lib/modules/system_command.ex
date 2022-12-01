defmodule AoC.Modules.SystemCommand do
  @moduledoc """
  Helper functions for system commands
  """

  @doc """
  Gets day from command line arguments
  """
  @spec get_day() :: {integer, String.t()} | nil
  def get_day do
    try do
      System.argv()
      |> Enum.at(0)
      |> String.to_integer()
      |> Integer.to_string()
      |> then(fn day -> {day, String.pad_leading(day, 2, "0")} end)
    rescue
      _ ->
        nil
    end
  end
end
