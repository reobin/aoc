defmodule AoC.Modules.Grid do
  @moduledoc """
  Module for a 2D grid made of points
  """

  alias AoC.Modules.Grid
  alias AoC.Modules.Point

  @doc """
  Returns all points in a grid
  """
  def get_points(nil), do: []
  def get_points(grid), do: grid |> Map.keys()

  @doc """
  Returns all neighbors of a point that exist on the grid
  """
  def get_neighbors(point, grid), do: get_neighbors(point, grid, 4)

  def get_neighbors(point, grid, count),
    do: point |> Point.get_neighbors(count) |> Enum.filter(&(not is_nil(Grid.get(grid, &1))))

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
  Counts occurences of a value
  """
  def count(grid), do: grid |> Grid.get_values() |> Enum.count()
  def count(grid, value), do: grid |> Grid.get_values() |> Enum.count(&(&1 == value))

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

    points = Grid.get_points(grid)

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
  Updates a point with a new value
  """
  def set(grid, point, value), do: Map.put(grid, point, value)

  @doc """
  Replaces all values with a new one if found, does nothing if not
  """
  def replace(grid, value, new_value) do
    grid
    |> Grid.get_points()
    |> Enum.reduce(grid, fn point, grid ->
      if Grid.get(grid, point) == value, do: Grid.set(grid, point, new_value), else: grid
    end)
  end

  @doc """
  Prints the grid in a 2D string
  """
  def print(grid, options \\ [])
  def print(nil, _options), do: nil

  def print(grid, options) do
    IO.puts("\n#{Grid.to_string(grid, options)}\n")
    grid
  end

  @doc """
  Returns the string representation of a grid
  """
  def to_string(grid, options \\ [])
  def to_string(nil, _options), do: ""

  def to_string(grid, options) do
    default_options = %{
      row_divider: "\n",
      column_divider: "",
      cell_width: 1,
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
    default_options = %{row_divider: "\n", column_divider: "", is_integer?: false}
    options = Enum.into(options, default_options)

    rows = String.split(value, options.row_divider, trim: true)

    height = Enum.count(rows)
    width = rows |> Enum.at(0) |> String.split(options.column_divider, trim: true) |> Enum.count()

    for(x <- 0..(width - 1), y <- 0..(height - 1), do: {x, y})
    |> Enum.reduce(%{}, fn {x, y}, grid ->
      cell = rows |> Enum.at(y) |> String.split(options.column_divider, trim: true) |> Enum.at(x)
      cell = if options.is_integer?, do: String.to_integer(cell), else: cell
      Grid.set(grid, {x, y}, cell)
    end)
  end

  @doc """
  Adds a layer of points around a grid
  """
  def add_layer(grid, value) do
    points = Grid.get_points(grid)

    min_x_index = points |> Enum.map(&elem(&1, 0)) |> Enum.min(fn -> -1 end)
    max_x_index = points |> Enum.map(&elem(&1, 0)) |> Enum.max(fn -> -1 end)

    min_y_index = points |> Enum.map(&elem(&1, 1)) |> Enum.min(fn -> -1 end)
    max_y_index = points |> Enum.map(&elem(&1, 1)) |> Enum.max(fn -> -1 end)

    top = (min_x_index - 1)..(max_x_index + 1) |> Enum.map(&{&1, min_y_index - 1})
    right = min_y_index..max_y_index |> Enum.map(&{max_x_index + 1, &1})
    bottom = (min_x_index - 1)..(max_x_index + 1) |> Enum.map(&{&1, max_y_index + 1})
    left = min_y_index..max_y_index |> Enum.map(&{min_x_index - 1, &1})

    (top ++ right ++ bottom ++ left)
    |> Enum.reduce(grid, &Grid.set(&2, &1, value))
  end

  @doc """
  Expands a grid by copying it in x and y
  """
  def expand(grid, x_multiplier, y_multiplier),
    do: expand(grid, x_multiplier, y_multiplier, fn value, _distance -> value end)

  def expand(grid, w_multiplier, h_multiplier, get_value) do
    {width, height} = Grid.get_size(grid)

    new_width = width * w_multiplier
    new_height = height * h_multiplier

    for(x <- 0..(new_width - 1), y <- 0..(new_height - 1), do: {x, y})
    |> Enum.reduce(grid, fn {x, y} = point, grid ->
      dx = floor(x / width)
      dy = floor(y / height)

      ox = if x > width - 1, do: x - width * dx, else: x
      oy = if y > height - 1, do: y - height * dy, else: y

      value = grid |> Grid.get({ox, oy}) |> get_value.({dx, dy})
      Grid.set(grid, point, value)
    end)
  end
end
