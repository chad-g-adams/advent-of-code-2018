defmodule Day1Part1 do
  def find_frequency(filepath) do
    data = File.stream!(filepath)

    data
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end
