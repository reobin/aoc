defmodule AoC.Helpers.SystemHelper do
  @moduledoc """
  Helper functions for system commands
  """

  @doc """
  Gets day from command line arguments
  """
  def get_day do
    try do
      System.argv()
      |> Enum.at(0)
      |> String.to_integer()
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    rescue
      _ ->
        nil
    end
  end
end
