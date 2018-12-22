defmodule Day18Part1 do
  @moduledoc """
  Day 18 Commentary:
  Felt really good about solving this one, my growing familiarity with the elixir
  modules is starting to pay off.
  Assist to my wife for talking through Part 2 strategy with me.
  """

  def get_resource_value(input, max_minutes) do
    initial_state = input |> Enum.map(&String.trim/1) |> parse_input

    %{trees: trees, lumberyard: lumberyards} =
      Stream.unfold({0, initial_state}, fn
        {current_min, current_state} when current_min <= max_minutes ->
          {current_state, {current_min + 1, current_state |> transition_state}}

        {_, _} ->
          nil
      end)
      |> Enum.map(&Map.to_list/1)
      |> Enum.map(&count_types/1)
      |> Enum.at(-1)

    trees * lumberyards
  end

  @doc """
    iex> Day18Part1.parse_input([
    ...>   ".#.#...|#.",
    ...>   ".....#|##|"
    ...> ])
    %{
      {1,1} => :open,
      {2,1} => :lumberyard,
      {3,1} => :open,
      {4,1} => :lumberyard,
      {5,1} => :open,
      {6,1} => :open,
      {7,1} => :open,
      {8,1} => :trees,
      {9,1} => :lumberyard,
      {10,1} => :open,
      {1,2} => :open,
      {2,2} => :open,
      {3,2} => :open,
      {4,2} => :open,
      {5,2} => :open,
      {6,2} => :lumberyard,
      {7,2} => :trees,
      {8,2} => :lumberyard,
      {9,2} => :lumberyard,
      {10,2} => :trees
    }
  """
  def parse_input(input) do
    {_, result} =
      Enum.reduce(input, {1, %{}}, fn row, {y, acc} ->
        {_, new_acc} =
          Enum.map(String.to_charlist(row), fn char ->
            case char do
              ?. -> :open
              ?# -> :lumberyard
              ?| -> :trees
            end
          end)
          |> Enum.reduce({1, acc}, fn item, {x, acc} ->
            {x + 1, Map.put(acc, {x, y}, item)}
          end)

        {y + 1, new_acc}
      end)

    result
  end

  def transition_state(prev_state) do
    prev_state
    |> Enum.map(&transition_type(&1, neighbour_counts(prev_state, &1)))
    |> Enum.into(%{})
  end

  defp transition_type({point, :trees}, neighbour_counts) do
    if neighbour_counts[:lumberyard] >= 3 do
      {point, :lumberyard}
    else
      {point, :trees}
    end
  end

  defp transition_type({point, :lumberyard}, neighbour_counts) do
    if neighbour_counts[:lumberyard] >= 1 and neighbour_counts[:trees] >= 1 do
      {point, :lumberyard}
    else
      {point, :open}
    end
  end

  defp transition_type({point, :open}, neighbour_counts) do
    if neighbour_counts[:trees] >= 3 do
      {point, :trees}
    else
      {point, :open}
    end
  end

  defp neighbour_counts(grid_map, {{px, py}, _}) do
    neighbour_types =
      for x <- (px - 1)..(px + 1),
          y <- (py - 1)..(py + 1),
          type = Map.get(grid_map, {x, y}),
          {x, y} != {px, py} and type != nil do
        type
      end
      |> Enum.group_by(fn t -> t end)

    %{
      trees: Map.get(neighbour_types, :trees, []) |> Enum.count(),
      open: Map.get(neighbour_types, :open, []) |> Enum.count(),
      lumberyard: Map.get(neighbour_types, :lumberyard, []) |> Enum.count()
    }
  end

  def count_types(grid_map) do
    grouped_result =
      grid_map
      |> Enum.group_by(fn {_p, type} -> type end)

    %{
      trees: Map.get(grouped_result, :trees, []) |> Enum.count(),
      open: Map.get(grouped_result, :open, []) |> Enum.count(),
      lumberyard: Map.get(grouped_result, :lumberyard, []) |> Enum.count()
    }
  end
end
