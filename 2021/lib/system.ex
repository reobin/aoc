defmodule AoC.System do
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

  @doc """
  Write content to file path
  """
  def write(path, content) do
    case File.open(path, [:write]) do
      {:ok, file} ->
        IO.binwrite(file, content)
        File.close(file)
        {:ok}

      _ ->
        {:error}
    end
  end
end
