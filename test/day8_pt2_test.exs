defmodule Day8Part2Test do
  use ExUnit.Case
  doctest Day8Part2

  test "sample" do
    assert 66 == Day8Part2.calculate_value_of_root_node("2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2")
  end
end
