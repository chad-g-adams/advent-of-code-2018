defmodule Day3Part1Test do
  use ExUnit.Case
  doctest Day3Part1

  test "sample" do
    assert 4 == MapSet.size(Day3Part1.find_overlapping_squares('test/data/Day3test'))
  end
end
