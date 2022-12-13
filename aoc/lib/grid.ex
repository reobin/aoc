defmodule AoC.Grid do
  @moduledoc """
  Module for a 2D grid made of points.
  """

  alias AoC.Grid
  alias AoC.Point

  @type point :: {integer(), integer()}
  @type grid :: %{point() => any()}
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
  @spec print(grid()) :: grid()
  def print(grid, options \\ [])
  def print(nil, _options), do: nil

  def print(grid, options) do
    IO.puts("\n#{Grid.to_string(grid, options)}\n")
    grid
  end

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
    default_options = %{row_divider: "\n", column_divider: "", integer?: false}
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

  @doc """
  Adds a layer of points around a grid
  """
  @spec add_layer(grid(), any()) :: grid()
  def add_layer(grid, value) do
    points = Grid.points(grid)

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
  @spec expand(grid(), integer(), integer()) :: grid()
  def expand(grid, x_multiplier, y_multiplier),
    do: expand(grid, x_multiplier, y_multiplier, fn value, _distance -> value end)

  @spec expand(grid(), integer(), integer(), (any() -> any())) :: grid()
  def expand(grid, w_multiplier, h_multiplier, get_value) do
    {width, height} = Grid.size(grid)

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

  @type shortest_path_state() :: %{
          map: grid(),
          target: point(),
          queue: [{integer(), point()}],
          found: %{point() => boolean()}
        }

  @doc """
  Finds the shortest path between two nodes in a graph.
  """
  @spec shortest_path(grid(), point(), point()) :: integer()
  def shortest_path(map, from, to, options \\ []) do
    default_options = %{
      can_move?: fn _map, _from, _to -> true end,
      cost: fn _map, _point -> 1 end
    }

    options = Enum.into(options, default_options)

    compute_cost(%{map: map, target: to, queue: [{0, from}], found: %{from => true}}, options)
  end

  @spec compute_cost(shortest_path_state(), map()) :: integer()
  defp compute_cost(%{queue: [{cost, target} | _rest], target: target}, _options), do: cost
  defp compute_cost(%{queue: []}, _options), do: :infinity

  defp compute_cost(state, options) do
    [{cost, point} | queue] = state.queue

    point
    |> Grid.neighbors(state.map)
    |> Enum.filter(&(is_nil(state.found[&1]) and options.can_move?.(state.map, point, &1)))
    |> Enum.reduce(%{state | queue: queue}, &add_to_queue(&1, &2, cost, options))
    |> sort_queue()
    |> compute_cost(options)
  end

  defp add_to_queue(neighbor, state, base_cost, options) do
    cost = base_cost + options.cost.(state.map, neighbor)

    queue = state.queue ++ [{cost, neighbor}]
    found = Map.put(state.found, neighbor, true)

    %{state | queue: queue, found: found}
  end

  defp sort_queue(state), do: Map.put(state, :queue, Enum.sort_by(state.queue, &elem(&1, 0)))
end
