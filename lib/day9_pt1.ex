defmodule Day9Part1 do
  @moduledoc """

    Day 9 Commentary:
    Parts 1 & 2 solved by the same module.
    Nice to use Stream.unfold for the first time, also learned how to sleep in elixir.
  """

  def generate_field_over_time(input) do
    coords_map = input
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_row/1)
    |> Enum.map(fn {point, velocity} -> {point, [velocity]} end)
    |> Enum.into(%{})

    Stream.unfold(coords_map, fn coords_map -> {coords_map, coords_map |> move} end)
    |> Enum.reduce(0, fn coords_map, acc ->
      {{min_x, _}, {max_x, _}} = coords_map |> Map.keys |> Enum.min_max_by(fn {x, _} -> x end)
      {{_, min_y}, {_, max_y}} = coords_map |> Map.keys |> Enum.min_max_by(fn {_, y} -> y end)

      if abs(max_x - min_x) < 100 do
        IO.puts("Second ##{acc}")
        coords_map |> print({min_x, max_x}, {min_y, max_y})
        IO.puts("\n\n")
        :timer.sleep(1000)
      end
      acc + 1
    end)
  end

  def print(coords_map, {min_x, max_x}, {min_y, max_y}) do
    str = Enum.reduce(min_y..max_y, "", fn y, acc ->
      Enum.reduce(min_x..max_x, acc, fn x, acc ->
        acc <> case coords_map[{x,y}] do
          nil -> "."
          _ -> "#"
        end
      end) <> "\n"
    end)
    IO.puts(str)
    coords_map
  end

  def move(coords_map) do
    coords_map
    |> Map.to_list
    |> Enum.reduce(%{}, fn {{x,y}, velocities}, acc ->
      Enum.reduce(velocities, acc, fn {vx, vy}, acc -> Map.update(acc, {x+vx,y+vy}, [{vx, vy}], &[{vx, vy} | &1]) end)
    end)
  end

  @doc """
    iex> Day9Part1.parse_row("position=<-3,  6> velocity=< 2, -1>")
    {{-3, 6}, {2, -1}}

    iex> Day9Part1.parse_row("position=< 9,  1> velocity=< 0,  2>")
    {{9, 1}, {0, 2}}

    iex> Day9Part1.parse_row("position=< 7,  0> velocity=<-1,  0>")
    {{7, 0}, {-1, 0}}
  """
  def parse_row(row) do
    result = Regex.named_captures(~r/position=<[ ]*(?<x>[-]?[0-9]+),[ ]*(?<y>[-]?[0-9]+)> velocity=<[ ]*(?<vx>[-]?[0-9]+),[ ]*(?<vy>[-]?[0-9]+)>/, row)
    {{String.to_integer(result["x"]), String.to_integer(result["y"])},
    {String.to_integer(result["vx"]), String.to_integer(result["vy"])}}
  end

end
