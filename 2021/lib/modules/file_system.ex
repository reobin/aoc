defmodule AoC.Modules.FileSystem do
  @moduledoc """
  Helper functions for file I/O
  """

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
