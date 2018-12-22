defmodule Day18Part1Test do
  use ExUnit.Case
  doctest Day18Part1

  test "resource value" do
    assert 1147 == Day18Part1.get_resource_value(File.stream!('test/data/Day18test'), 10)
  end
end
