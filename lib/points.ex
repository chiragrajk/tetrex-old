defmodule Tetris.Points do

  @doc """
  Rotates list of points

  ## Example
    iex> Tetris.Brick.new() |> Tetris.Brick.shape() |> Tetris.Points.translate({1, 1})
    [{3, 2}, {3, 3}, {3, 4}, {3, 5}]
  """
  def translate(points, {x, y}) do
    points
    |> Enum.map(fn {dx, dy} -> {dx + x, dy + y} end)
  end
end
