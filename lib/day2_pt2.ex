defmodule Day2Part2 do
  def find_common_characters_for_words_one_char_apart(filepath) do
    File.stream!(filepath)
    |> Enum.map(&String.trim/1)
    |> find_word_with_one_char_difference
  end

  defp find_word_with_one_char_difference([head | tail]) do
    if match = Enum.find(tail, &has_one_character_difference?(&1, head)) do
      find_common_characters(match, head)
    else
      find_word_with_one_char_difference(tail)
    end
  end

  defp has_one_character_difference?(str1, str2) do
    differences =
      Enum.zip(String.to_charlist(str1), String.to_charlist(str2))
      |> Enum.count(fn {left, right} -> left != right end)

    differences == 1
  end

  defp find_common_characters(str1, str2) do
    Enum.zip(String.to_charlist(str1), String.to_charlist(str2))
    |> Enum.reject(fn {left, right} -> left != right end)
    |> Enum.map(fn {left, _right} -> left end)
  end
end
