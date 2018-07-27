defmodule ImageTest do
  use ExUnit.Case
  doctest Identicon.Image

  test "greets the world" do
    assert %Identicon.Image{} == %Identicon.Image{color: nil, grid: nil, hex: nil, pixel_map: nil}
  end
end
