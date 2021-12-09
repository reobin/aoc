defmodule AoC.Modules.Grid do
  @moduledoc """
  Module for a 2D grid made of points
  """

  alias AoC.Modules.Grid

  @doc """
  Returns all points in a grid
  """
  def get_points(nil), do: []
  def get_points(grid), do: grid |> Map.keys()

  @doc """
  Returns all values in a grid
  """
  def get_values(nil), do: []
  def get_values(grid), do: grid |> Map.values()

  @doc """
  Returns the value at a point
  """
  def get(nil, _point), do: nil
  def get(grid, point), do: Map.get(grid, point)
  def get(nil, _point, _default), do: nil
  def get(grid, point, default), do: Map.get(grid, point, default)

  @doc """
  Returns a size in width and height
  """
  def get_size(nil), do: {0, 0}

  def get_size(grid) do
    points = Grid.get_points(grid)

    max_x_index = points |> Enum.map(&elem(&1, 0)) |> Enum.max(fn -> -1 end)
    max_y_index = points |> Enum.map(&elem(&1, 1)) |> Enum.max(fn -> -1 end)

    {max_x_index + 1, max_y_index + 1}
  end

  @doc """
  Returns the point at which a value is found
  """
  def find(grid, value) do
    grid
    |> Grid.get_points()
    |> Enum.find(fn point -> Grid.get(grid, point) == value end)
  end

  @doc """
  Returns a list of rows with each column value
  """
  def get_rows(nil), do: []

  def get_rows(grid) do
    {width, height} = Grid.get_size(grid)

    if width > 0 and height > 0 do
      0..(height - 1)
      |> Enum.map(fn y -> 0..(width - 1) |> Enum.map(fn x -> grid[{x, y}] end) end)
    else
      []
    end
  end

  @doc """
  Returns a list of columns with each row value
  """
  def get_columns(nil), do: []

  def get_columns(grid) do
    {width, height} = Grid.get_size(grid)

    if width > 0 and height > 0 do
      0..(width - 1)
      |> Enum.map(fn x -> 0..(height - 1) |> Enum.map(fn y -> grid[{x, y}] end) end)
    else
      []
    end
  end

  @doc """
  Returns all points between 2 points
  """
  def get_line(point_1, point_2), do: get_line(point_1, point_2, [])
  def get_line({x1, y1}, {x2, y2}, points) when x1 == x2 and y1 == y2, do: points ++ [{x2, y2}]

  def get_line({x1, y1}, {x2, y2}, points) do
    get_multiplier = fn a, b -> if a == b, do: 0, else: if(a > b, do: -1, else: 1) end

    multiplier_x = get_multiplier.(x1, x2)
    multiplier_y = get_multiplier.(y1, y2)

    next = {x1 + 1 * multiplier_x, y1 + 1 * multiplier_y}

    points ++ get_line(next, {x2, y2}, [{x1, y1}])
  end

  @doc """
  Returns all points adjacent to a point
  """
  def get_adjacent_points({x, y}), do: [{x, y - 1}, {x + 1, y}, {x, y + 1}, {x - 1, y}]

  @doc """
  Updates a point with a new value
  """
  def set(board, point, value), do: Map.put(board, point, value)

  @doc """
  Replaces a value with a new one if found, does nothing if not
  """
  def replace_value(board, value, new_value) do
    point = Grid.find(board, value)

    if is_nil(point) do
      board
    else
      Grid.set(board, point, new_value)
    end
  end

  @doc """
  Prints the grid in a 2D string
  """
  def print(grid, options \\ [])
  def print(nil, _options), do: "grid is null"
  def print(grid, options), do: IO.puts("\n#{Grid.to_string(grid, options)}\n")

  @doc """
  Returns the string representation of a grid
  """
  def to_string(grid, options \\ [])
  def to_string(nil, _options), do: ""

  def to_string(grid, options) do
    default_options = %{
      row_divider: "\n",
      column_divider: " ",
      cell_width: 2,
      replace_nil_with: nil
    }

    options = Enum.into(options, default_options)

    grid
    |> Grid.get_rows()
    |> Enum.map(fn row ->
      row
      |> Enum.map(fn value ->
        value = if is_nil(value), do: options.replace_nil_with, else: value
        value = if is_integer(value), do: Integer.to_string(value), else: value
        String.pad_leading(value, options.cell_width, " ")
      end)
      |> Enum.join(options.column_divider)
    end)
    |> Enum.join(options.row_divider)
  end

  @doc """
  From a 2D string value, build a grid
  """
  def from_string(""), do: nil
  def from_string(nil), do: nil

  def from_string(value, options \\ []) do
    default_options = %{row_divider: "\n", column_divider: " ", is_integer?: false}
    options = Enum.into(options, default_options)

    value
    |> String.split(options.row_divider, trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, grid ->
      line
      |> String.split(options.column_divider, trim: true)
      |> Enum.with_index()
      |> Enum.reduce(grid, fn {cell, x}, grid ->
        cell = if options.is_integer?, do: String.to_integer(cell), else: cell
        Grid.set(grid, {x, y}, cell)
      end)
    end)
  end
end
