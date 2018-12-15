defmodule Day5Part1 do
  @moduledoc """
    For this solution, I found that converting each character to a String in order to do downcase() 
    was performance impacting (total 30 seconds to solve puzzle). So I switched to using assumption
    that input was only ascii letters (and added a validation check to ensure this). 
    Then I could compare upper/lower case by adding 32 to the value (solution runs 15x faster)
  """

  def find_remaining_polymer_units(input) do
    input
    |> validate_ascii_letters
    |> find_remaining_polymer_units_no_validation
  end

  def find_remaining_polymer_units_no_validation(input) do
    input
    |> Enum.reduce([], &apply_character_to_polymer/2)
    |> Enum.count()
  end

  def validate_ascii_letters(input) do
    if Enum.find(input, fn c -> c < 65 or c > 122 end) != nil do
      throw("Failed to validate character")
    end

    input
  end

  defp apply_character_to_polymer(char, _polymer = []) do
    [char]
  end

  defp apply_character_to_polymer(char, polymer = [head | tail]) do
    if char == head - 32 or char == head + 32 do
      tail
    else
      [char | polymer]
    end
  end
end
