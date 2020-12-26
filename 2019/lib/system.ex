defmodule AoC.System do
  def get_day do
    System.argv()
    |> Enum.at(0)
    |> String.to_integer()
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

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
