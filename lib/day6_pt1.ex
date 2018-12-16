defmodule Day6Part1 do
  @moduledoc """
  Day 6 Commentary:
    The performance of this solution is lacking, it took 30 seconds to solve Part 1 on my laptop.
    Part 2 solution was even worse - 2 min 26 s.
    If I had more time I would go back and optimize!
  """
  def largest_finite_area(coordinates_strings) do
    coordinates_list = parse_coordinates(coordinates_strings)

    {{min_x, _}, {max_x, _}} = coordinates_list |> Enum.min_max_by(fn {x, _} -> x end)
    {{_, min_y}, {_, max_y}} = coordinates_list |> Enum.min_max_by(fn {_, y} -> y end)

    result_map =
      coordinates_list
      |> Enum.reduce(%{}, fn p, acc ->
        Enum.reduce(min_x..max_x, acc, fn x, acc ->
          Enum.reduce(min_y..max_y, acc, fn y, acc ->
            distance = get_manhattan_distance_between_two_points(p, {x, y})

            Map.update(
              acc,
              {x, y},
              {distance, [p]},
              &calculate_result_for_square({distance, p}, &1)
            )
          end)
        end)
      end)

    find_finite_area_for_each_coordinate(
      coordinates_list,
      result_map,
      {min_x, max_x, min_y, max_y}
    )
    |> Enum.max()
  end

  def parse_coordinates(coordinates_strings) do
    coordinates_strings
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn line ->
      [x, y] = String.split(line, ", ")
      {String.to_integer(x), String.to_integer(y)}
    end)
  end

  def find_finite_area_for_each_coordinate(
        coordinates_list,
        result_map,
        {min_x, max_x, min_y, max_y}
      ) do
    result_list = Map.to_list(result_map)

    coordinates_list
    |> Enum.filter(fn {x, y} -> x > min_x and x < max_x and y > min_y and y < max_y end)
    |> Enum.map(fn coordinate ->
      result_list
      |> Enum.filter(fn {_coord, {_distance, points}} ->
        Enum.count(points) == 1 and coordinate in points
      end)
      |> Enum.count()
    end)
  end

  defp calculate_result_for_square({distance, p}, {existing_distance, _})
       when distance < existing_distance do
    {distance, [p]}
  end

  defp calculate_result_for_square({distance, _}, {existing_distance, existing_points})
       when distance > existing_distance do
    {existing_distance, existing_points}
  end

  defp calculate_result_for_square({distance, p}, {_, existing_points}) do
    {distance, [p | existing_points]}
  end

  @doc """
    iex> Day6Part1.get_manhattan_distance_between_two_points({1, 1}, {5, 8})
    11

    iex> Day6Part1.get_manhattan_distance_between_two_points({3, 4}, {3, 5})
    1
  """
  def get_manhattan_distance_between_two_points({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end
end
