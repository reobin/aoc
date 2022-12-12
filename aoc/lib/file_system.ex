defmodule AoC.FileSystem do
  @moduledoc """
  Helper functions for file I/O.
  """

  @doc """
  Writes content to file path.
  """
  @spec write(String.t(), String.t()) :: :ok | :error
  def write(path, content) do
    case File.open(path, [:write]) do
      {:ok, file} ->
        IO.binwrite(file, content)
        File.close(file)
        :ok

      _ ->
        :error
    end
  end
end
