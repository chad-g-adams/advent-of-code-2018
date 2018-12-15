defmodule Day1Part1Test do
  use ExUnit.Case
  doctest Day1Part1

  test "sample" do
    assert -6 == Day1Part1.find_frequency('test/data/Day1test')
  end
end
