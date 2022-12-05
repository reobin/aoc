defmodule AoC.Modules.Stack do
  @moduledoc """
  Helper functions to work with stacks.
  """

  @doc """
  Returns first element(s) of the stack, and removes it/them from the stack.
  """
  @spec pop(list()) :: {any(), list()}
  def pop(stack), do: pop(stack, 1)

  @spec pop(list(), integer()) :: {any(), list()}
  def pop([], 1), do: {nil, []}
  def pop([top | stack], 1), do: {top, stack}

  def pop(stack, count) do
    top = Enum.slice(stack, 0, count)
    stack = Enum.drop(stack, count)
    {top, stack}
  end

  @doc """
  Pushes a value or more onto the stack.
  """
  @spec push(list(), list(any())) :: list()
  def push(stack, items) when is_list(items), do: items ++ stack
  @spec push(list(), any()) :: list()
  def push(stack, item), do: push(stack, [item])

  @doc """
  Returns the element at the top of the stack.
  """
  @spec top(list()) :: any()
  def top([]), do: nil
  def top([top | _stack]), do: top
end
