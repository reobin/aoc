defmodule AoC.Modules.Grid do
  @moduledoc """
  Module for a 2D grid made of points.
  """

  alias AoC.Modules.Grid
  alias AoC.Modules.Point

  @type grid :: map()
  @type point :: {integer(), integer()}
  @type size :: {integer(), integer()}

  @doc """
  Returns all points in a grid
  """
  @spec points(grid()) :: [point()]
  def points(nil), do: []
  def points(grid), do: grid |> Map.keys()

  @doc """
  Returns all values in a grid
  """
  @spec values(grid()) :: [any()]
  def values(nil), do: []
  def values(grid), do: grid |> Map.values()

  @doc """
  Returns the value at a point
  """
  @spec get(grid(), point()) :: any() | nil
  def get(nil, _point), do: nil
  def get(grid, point), do: Map.get(grid, point)
  def get(nil, _point, _default), do: nil
  def get(grid, point, default), do: Map.get(grid, point, default)

  @doc """
  Counts occurences of a value
  """
  @spec count(grid()) :: integer()
  def count(grid), do: grid |> Grid.values() |> Enum.count()
  @spec count(grid(), any()) :: integer()
  def count(grid, value), do: grid |> Grid.values() |> Enum.count(&(&1 == value))

  @doc """
  Returns a size in width and height
  """
  @spec size(grid()) :: size()
  def size(nil), do: {0, 0}
  def size(grid) when grid == %{}, do: {0, 0}

  def size(grid) do
    points = Grid.points(grid)

    min_x_index = points |> Enum.map(&elem(&1, 0)) |> Enum.min(fn -> -1 end)
    max_x_index = points |> Enum.map(&elem(&1, 0)) |> Enum.max(fn -> -1 end)

    min_y_index = points |> Enum.map(&elem(&1, 1)) |> Enum.min(fn -> -1 end)
    max_y_index = points |> Enum.map(&elem(&1, 1)) |> Enum.max(fn -> -1 end)

    {max_x_index - min_x_index + 1, max_y_index - min_y_index + 1}
  end

  @doc """
  Returns the point at which a value is found
  """
  @spec find(grid(), any()) :: point() | nil
  def find(grid, value) do
    grid
    |> Grid.points()
    |> Enum.find(fn point -> Grid.get(grid, point) == value end)
  end

  @doc """
  Returns a list of rows with each column value
  """
  @spec rows(grid()) :: [[any()]]
  def rows(nil), do: []

  def rows(grid) do
    {width, height} = Grid.size(grid)

    points = Grid.points(grid)

    min_x_index = points |> Enum.map(&elem(&1, 0)) |> Enum.min(fn -> -1 end)
    max_x_index = points |> Enum.map(&elem(&1, 0)) |> Enum.max(fn -> -1 end)

    min_y_index = points |> Enum.map(&elem(&1, 1)) |> Enum.min(fn -> -1 end)
    max_y_index = points |> Enum.map(&elem(&1, 1)) |> Enum.max(fn -> -1 end)

    if width > 0 and height > 0 do
      min_y_index..max_y_index
      |> Enum.map(fn y -> min_x_index..max_x_index |> Enum.map(fn x -> grid[{x, y}] end) end)
    else
      []
    end
  end

  @doc """
  Returns a list of columns with each row value
  """
  @spec columns(grid()) :: [[any()]]
  def columns(nil), do: []

  def columns(grid) do
    {width, height} = Grid.size(grid)

    if width > 0 and height > 0 do
      0..(width - 1)
      |> Enum.map(fn x -> 0..(height - 1) |> Enum.map(fn y -> grid[{x, y}] end) end)
    else
      []
    end
  end

  @doc """
  Returns all neighbors of a point that exist on the grid
  """
  @spec neighbors(point(), grid()) :: [point()]
  def neighbors(point, grid), do: neighbors(point, grid, 4)

  @spec neighbors(point(), grid(), integer()) :: [point()]
  def neighbors(point, grid, count),
    do: point |> Point.neighbors(count) |> Enum.filter(&(not is_nil(Grid.get(grid, &1))))

  @doc """
  Updates a point with a new value
  """
  @spec set(grid(), point(), any()) :: grid()
  def set(grid, point, value), do: Map.put(grid, point, value)

  @doc """
  Replaces all values with a new one if found, does nothing if not
  """
  @spec replace(grid(), any(), any()) :: grid()
  def replace(grid, value, new_value) do
    grid
    |> Grid.points()
    |> Enum.reduce(grid, fn point, grid ->
      if Grid.get(grid, point) == value, do: Grid.set(grid, point, new_value), else: grid
    end)
  end

  @doc """
  Prints the grid in a 2D string
  """
  @spec print(grid()) :: String.t()
  def print(grid, options \\ [])
  def print(nil, _options), do: "grid is null"
  def print(grid, options), do: IO.puts("\n#{Grid.to_string(grid, options)}\n")

  @doc """
  Returns the string representation of a grid
  """
  @spec to_string(grid()) :: String.t()
  def to_string(grid, options \\ [])
  def to_string(nil, _options), do: ""

  def to_string(grid, options) do
    default_options = %{
      row_divider: "\n",
      column_divider: "",
      cell_width: 1,
      replace_nil_with: " "
    }

    options = Enum.into(options, default_options)

    grid
    |> Grid.rows()
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
  @spec from_string(String.t()) :: grid()
  def from_string(""), do: nil
  def from_string(nil), do: nil

  def from_string(value, options \\ []) do
    default_options = %{row_divider: "\n", column_divider: " ", integer?: false}
    options = Enum.into(options, default_options)

    value
    |> String.split(options.row_divider, trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, grid ->
      line
      |> String.split(options.column_divider, trim: true)
      |> Enum.with_index()
      |> Enum.reduce(grid, fn {cell, x}, grid ->
        cell = if options.integer?, do: String.to_integer(cell), else: cell
        Grid.set(grid, {x, y}, cell)
      end)
    end)
  end
end
