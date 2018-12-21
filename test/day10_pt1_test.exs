defmodule Day10Part1Test do
  use ExUnit.Case
  doctest Day10Part1

  test "power level for cell" do
    assert 4 == Day10Part1.get_power_level_for_cell({3, 5}, 8)
    assert -5 == Day10Part1.get_power_level_for_cell({122, 79}, 57)
    assert 0 == Day10Part1.get_power_level_for_cell({217, 196}, 39)
    assert 4 == Day10Part1.get_power_level_for_cell({101, 153}, 71)
  end

  test "grid with largest power" do
    assert {{33, 45}, 29} == Day10Part1.get_grid_with_largest_power(18)
    assert {{21, 61}, 30} == Day10Part1.get_grid_with_largest_power(42)
  end
end
