defmodule Day6Part1Test do
  use ExUnit.Case
  doctest Day6Part1

  test "sample" do
    assert 17 ==
             Day6Part1.largest_finite_area([
               "1, 1",
               "1, 6",
               "8, 3",
               "3, 4",
               "5, 5",
               "8, 9"
             ])
  end
end
