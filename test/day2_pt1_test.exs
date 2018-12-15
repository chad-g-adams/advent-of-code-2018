defmodule Day2Part1Test do
  use ExUnit.Case
  doctest Day2Part1

  test "sample" do
    assert 12 == Day2Part1.find_checksum('test/data/Day2test')
  end
end
