defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "It should return :ok" do
    status = Identicon.main("test")
    assert status == :ok
    File.rm("test.png")
  end

  test "It should generate an %Identicon.Image struct with the string converted to bin list" do
    test_string = "test"
    assert Identicon.hash_input(test_string) == %Identicon.Image{hex: :binary.bin_to_list(:crypto.hash(:md5, test_string))}
  end
end
