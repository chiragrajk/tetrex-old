defmodule BrickTest do
  use ExUnit.Case
  doctest Tetris.Brick

  import Tetris.Brick
  alias Tetris.{Brick, Points}

  test "Creae a new brick" do
    assert new().name == :i
  end

  test "Create a rondom brick" do
    brick = new_random()

    assert brick.name in [:i, :l, :z, :t, :o]
    assert brick.rotation in [0, 90, 180, 270]
    assert brick.reflection in [true, false]
  end

  test "should manipulate brick" do
    actual =
      new()
      |> left
      |> right
      |> right
      |> down
      |> spin_90
      |> spin_90

    assert actual.location == {41, 1}
    assert actual.rotation == 180
  end

  # def new_brick(attr \\ []), do: new(attr)
  test "should flip rotatate and mirror" do
    [{1, 1}]
    |> Points.mirror()
    |> assert_point({4, 1})
    |> Points.flip()
    |> assert_point({4, 4})
    |> Points.rotate_90()
    |> assert_point({1, 4})
    |> Points.rotate_90()
    |> assert_point({1, 1})
  end

  def assert_point([actual], expected) do
    assert actual == expected
    [actual]
  end
end
