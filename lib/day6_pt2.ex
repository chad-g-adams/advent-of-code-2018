defmodule Day6Part2 do
  @moduledoc """
  """

  @doc """
    Given a set of coordinates (in string format), return the number of points
    in the space that are within less than `max_distance` of all coordinates.
  """
  def find_size_of_safe_region(coordinates_strings, max_distance) do
    coordinates_list = Day6Part1.parse_coordinates(coordinates_strings)

    {{min_x, _}, {max_x, _}} = coordinates_list |> Enum.min_max_by(fn {x, _} -> x end)
    {{_, min_y}, {_, max_y}} = coordinates_list |> Enum.min_max_by(fn {_, y} -> y end)

    result_map =
      Enum.reduce(min_x..max_x, %{}, fn x, acc ->
        Enum.reduce(min_y..max_y, acc, fn y, acc ->
          Enum.reduce(coordinates_list, acc, fn p, acc ->
            distance = Day6Part1.get_manhattan_distance_between_two_points(p, {x, y})

            Map.update(
              acc,
              {x, y},
              distance,
              &(&1 + distance)
            )
          end)
        end)
      end)

    result_map
    |> Map.to_list()
    |> Enum.filter(fn {_, distance} -> distance < max_distance end)
    |> Enum.count()
  end
end
