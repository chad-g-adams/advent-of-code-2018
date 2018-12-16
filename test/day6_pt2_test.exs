defmodule Day6Part2Test do
  use ExUnit.Case
  doctest Day6Part2

  test "sample" do
    assert 16 ==
             Day6Part2.find_size_of_safe_region(
               [
                 "1, 1",
                 "1, 6",
                 "8, 3",
                 "3, 4",
                 "5, 5",
                 "8, 9"
               ],
               32
             )
  end
end
