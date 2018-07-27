defmodule Identicon do
  @moduledoc """
  A module that generates an Identicon image from a string input.
  """

  @doc """
  It creates a identicon image file with same name of input string.

  ## Examples

      iex> Identicon.main("test")
      :ok
      iex> File.rm("test.png")
      :ok

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
  It receives an String an return an Image struct with that string converted to bin list.

  ## Examples

      iex> Identicon.hash_input("test")
      %Identicon.Image{hex: :binary.bin_to_list(:crypto.hash(:md5, "test"))}

  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image_struct) do
    %Identicon.Image{image_struct | color: {r,g,b}}
  end

  def build_grid(%Identicon.Image{hex: hex_list} = image_struct) do
    grid =
      hex_list
      |> Enum.chunk(3)
      # |> Enum.map(fn(x) -> mirror_row(x) end)
      |> Enum.map(&mirror_row/1) #need to passa a reference of a function in Enum.map
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image_struct | grid: grid}
  end

  def mirror_row([first, second, _middle] = row) do
    row ++ [second, first]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image_struct) do
    grid = Enum.filter(grid, fn({code, _index}) ->
      rem(code, 2) === 0 #calculates remainder division by 2
    end)

    %Identicon.Image{image_struct | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image_struct) do
    pixel_map = Enum.map(grid, fn({ _code, index }) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = { horizontal, vertical }
      bottom_right = { horizontal + 50, vertical + 50 }
      {top_left, bottom_right}
    end)

    %Identicon.Image{image_struct | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn({ top_left, bottom_right }) ->
      :egd.filledRectangle(image, top_left, bottom_right, fill)
    end)

    :egd.render(image)
  end

  def save_image(image, file_name) do
    File.write("#{file_name}.png", image)
  end
end
