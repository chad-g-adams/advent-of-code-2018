defmodule Day5Part1Test do
  use ExUnit.Case
  doctest Day5Part1

  defp build_input(string) do
    String.to_charlist(string)
  end

  test "Aa" do
    assert 0 == Day5Part1.find_remaining_polymer_units(build_input("Aa"))
  end

  test "dabAcCaCBAcCcaDA" do
    assert 10 == Day5Part1.find_remaining_polymer_units(build_input("dabAcCaCBAcCcaDA"))
  end
end
