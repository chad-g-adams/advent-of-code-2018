defmodule Day2Part1 do
  def find_checksum(filepath) do
    %{:two => two, :three => three} =
      File.stream!(filepath)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&build_score_for_id/1)
      |> Enum.reduce(%{:two => 0, :three => 0}, fn score,
                                                   _acc = %{:two => two, :three => three} ->
        %{
          :two => two + score[:two],
          :three => three + score[:three]
        }
      end)

    two * three
  end

  defp build_score_for_id(id) do
    count_map = build_character_counts_for_id(id)

    %{
      :two => has_a_character_with_exact_count(count_map, 2),
      :three => has_a_character_with_exact_count(count_map, 3)
    }
  end

  defp build_character_counts_for_id(id) do
    chars = String.to_charlist(id)

    chars
    |> Enum.reduce(%{}, fn c, acc ->
      Map.put(acc, c, Map.get(acc, c, 0) + 1)
    end)
  end

  defp has_a_character_with_exact_count(character_count_map, count_to_match) do
    found_match =
      character_count_map
      |> Map.to_list()
      |> Enum.any?(fn {_, count} -> count == count_to_match end)

    case found_match do
      true -> 1
      _ -> 0
    end
  end
end
