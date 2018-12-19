defmodule Day8Part1Test do
  use ExUnit.Case
  doctest Day8Part1

  test "sample" do
    assert 138 == Day8Part1.sum_metadata_entries("2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2")
  end
end
