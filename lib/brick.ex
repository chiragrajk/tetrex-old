defmodule Tetris.Brick do
  defstruct name: :i,
            location: {40, 0},
            rotation: 0,
            reflection: false

  @doc """
  Return brick struct

  ## Examples

    iex> Tetris.Brick.new()
    %Tetris.Brick{name: :i, location: {40, 0}, rotation: 0, reflection: false}
  """
  def new(attr \\ []), do: __struct__(attr)

  def new_random() do
    %__MODULE__{
      name: random_name(),
      location: {40, 0},
      rotation: random_rotation(),
      reflection: random_reflection()
    }
  end

  def random_name() do
    ~w(i l z o t)a
    |> Enum.random()
  end

  def random_rotation() do
    [0, 90, 180, 270]
    |> Enum.random()
  end

  def random_reflection do
    [true, false]
    |> Enum.random()
  end

  def left(brick) do
    %{brick | location: point_left(brick.location)}
  end

  def right(brick) do
    %{brick | location: point_right(brick.location)}
  end

  def up(brick) do
    %{brick | location: point_up(brick.location)}
  end

  def down(brick) do
    %{brick | location: point_down(brick.location)}
  end

  def point_left({x, y}) do
    {x - 1, y}
  end

  def point_right({x, y}) do
    {x + 1, y}
  end

  def point_down({x, y}) do
    {x, y + 1}
  end

  def point_up({x, y}) do
    {x, y - 1}
  end

  def spin_90(brick) do
    %{brick | rotation: rotate(brick.rotation)}
  end

  def rotate(270), do: 0

  def rotate(degrees) do
    degrees + 90
  end

  @doc """
  Return points for shape

  ## Examples
    iex> Tetris.Brick.shape(%{name: :l})
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {3, 3}
    ]

    iex> Tetris.Brick.new() |> Tetris.Brick.shape()
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {2, 4}
    ]

    iex> Tetris.Brick.new(name: :o) |> Tetris.Brick.shape()
    [
      {2, 2}, {3, 2},
      {2, 3}, {3, 3}
    ]

    iex> Tetris.Brick.shape(%{name: :z})
    [
      {2, 2},
      {2, 3}, {3, 3},
              {3, 4}
    ]

    iex> Tetris.Brick.shape(%{name: :t})
    [
      {2, 1},
      {2, 2}, {3, 2},
      {2, 3}
    ]

  """
  def shape(%{name: :l}) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def shape(%{name: :i}) do
    [
      {2, 1},
      {2, 2},
      {2, 3},
      {2, 4}
    ]
  end

  def shape(%{name: :o}) do
    [
      {2, 2},
      {3, 2},
      {2, 3},
      {3, 3}
    ]
  end

  def shape(%{name: :z}) do
    [
      {2, 2},
      {2, 3},
      {3, 3},
      {3, 4}
    ]
  end

  def shape(%{name: :t}) do
    [
      {2, 1},
      {2, 2},
      {3, 2},
      {2, 3}
    ]
  end

  def prepare(brick) do
    brick
    |> shape
    |> Tetris.Points.rotate(brick.rotation)
    |> Tetris.Points.mirror(brick.reflection)
  end

  def to_s(brick) do
    map =
      brick
      |> prepare
      |> Enum.map(fn p -> {p, "■"} end)
      |> Map.new()

    for x <- (1..4), y <- (1..4) do
      Map.get(map, {x, y}, "□")
    end
    |> Enum.chunk_every(4)
    |> Enum.map(&(Enum.join/1))
    |> Enum.join("\n")
  end

  def print(brick) do
    brick |> to_s() |> IO.puts

    brick
  end

  defimpl Inspect, for: Tetris.Brick do
    import Inspect.Algebra
    def inspect(brick, _opts) do
      concat(["\n", Tetris.Brick.to_s(brick), inspect(brick.location)])
    end
  end
end
