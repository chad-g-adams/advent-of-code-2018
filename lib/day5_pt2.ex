defmodule Day5Part2 do
  def find_shortest_possible_polymer_units(input) do
    input
    |> Day5Part1.validate_ascii_letters()

    unique_characters_found = input |> Enum.uniq()

    Enum.reduce(unique_characters_found, :infinity, fn char, len_of_shortest_polymer ->
      input
      |> remove_instances(char)
      |> Day5Part1.find_remaining_polymer_units_no_validation()
      |> polymer_min(len_of_shortest_polymer)
    end)
  end

  defp remove_instances(input, char) do
    Enum.filter(input, fn c -> c != char and c + 32 != char and c - 32 != char end)
  end

  defp polymer_min(val1, val2) when val2 == :infinity do
    val1
  end

  defp polymer_min(val1, val2) do
    min(val1, val2)
  end
end
