defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  describe "#main" do
    test "It should return :ok" do
      status = Identicon.main("test")
      assert status == :ok
      File.rm("test.png")
    end
  end

  describe "#hash_input" do
    test "It should generate an %Identicon.Image struct with the string converted to bin list" do
      test_string = "test"
      assert Identicon.hash_input(test_string) == %Identicon.Image{hex: :binary.bin_to_list(:crypto.hash(:md5, test_string))}
    end
  end

  describe "#pick_color" do
    test "It should return a new %Identicon.Image with color attribute" do
      image_struct = %Identicon.Image{hex: [1,2,3,4,5,6,7,8,9]}
      [r,g,b | _tail] = image_struct.hex
      assert Identicon.pick_color(image_struct) == %Identicon.Image{image_struct | color: {r,g,b}}
    end
  end

  describe "#build_grid" do
    test "It should return a new %Identicon.Image with grid attribute" do
      image_struct = %Identicon.Image{hex: [1,2,3,4,5,6,7,8,9]}
      grid =
        image_struct.hex
        |> Enum.chunk(3)
        |> Enum.map(&Identicon.mirror_row/1)
        |> List.flatten
        |> Enum.with_index

      assert Identicon.build_grid(image_struct) == %Identicon.Image{image_struct | grid: grid}
    end
  end
end
