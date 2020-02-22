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

  def transpose(points) do
    points |> Enum.map(fn {x, y} -> {y, x} end)
  end

  def mirror(points) do
    points |> Enum.map(fn {x, y} -> {5-x, y} end)
  end

  def flip(points) do
    points |> Enum.map(fn {x, y} -> {x, 5-y} end)
  end

  def rotate_90(points) do
    points
    |> transpose
    |> mirror
  end

  def rotate(points, 0), do: rotate_90(points)
  def rotate(points, degrees) do
    points
    |> rotate_90
    |> rotate(degrees - 90)
  end
end
