defmodule Day10Part1 do
  @moduledoc """
    Day 10 Commentary:
    Things I learned today, you can do pattern matching in anonymous functions!
    Part 1 was solved in a straightforward, albeit not great performance way.
    Part 2 The non-performant solution was no longer reasonable. I tried a few
     optimizations but couldn't make it fast enough. Then I found this hint:
     https://en.wikipedia.org/wiki/Summed-area_table
     but by that point it was the end of the night and I didn't feel like implementing it.
  """

  def get_grid_with_largest_power(serial) do
    build_grid(serial) |> get_max_power_amount_for_grid_size(3)
  end

  def build_grid(serial) do
    for x <- 1..300,
        y <- 1..300,
        point = {x, y},
        into: %{} do
      {point, get_power_level_for_cell(point, serial)}
    end
  end

  def get_max_power_amount_for_grid_size(full_grid, grid_size) do
    {max_power_point, power} =
      full_grid
      |> Enum.map(fn {point, _} ->
        {point, power_of_sub_grid(full_grid, grid_size, point)}
      end)
      |> Enum.max_by(fn {_point, power} -> power end)

    {max_power_point, power}
  end

  def power_of_sub_grid(full_grid, grid_size, _top_point = {top_x, top_y}) do
    power_values =
      for x <- top_x..(top_x + grid_size - 1),
          y <- top_y..(top_y + grid_size - 1),
          do: Map.get(full_grid, {x, y}, 0)

    Enum.sum(power_values)
  end

  def get_power_level_for_cell({x, y}, serial) do
    rack_id = x + 10
    intermediate_value = (rack_id * y + serial) * rack_id
    hundreds_digit = div(rem(intermediate_value, 1000), 100)
    hundreds_digit - 5
  end
end
