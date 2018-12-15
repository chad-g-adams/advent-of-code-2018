defmodule Day5Part2Test do
  use ExUnit.Case
  doctest Day5Part2

  defp build_input(string) do
    String.to_charlist(string)
  end

  test "dabAcCaCBAcCcaDA" do
    assert 4 == Day5Part2.find_shortest_possible_polymer_units(build_input("dabAcCaCBAcCcaDA"))
  end
end
