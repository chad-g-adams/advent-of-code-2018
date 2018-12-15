defmodule Day1Part2 do
  def first_duplicate_found(filepath) do
    result_stream =
      File.stream!(filepath)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.to_integer/1)
      |> Stream.cycle()
      |> Stream.scan(&(&1 + &2))

    first_duplicate_found =
      result_stream
      |> Enum.reduce_while(MapSet.new(), &find_first_duplicate/2)

    first_duplicate_found
  end

  defp find_first_duplicate(next_value, already_found_set) do
    if MapSet.member?(already_found_set, next_value) do
      {:halt, next_value}
    else
      {:cont, MapSet.put(already_found_set, next_value)}
    end
  end
end
