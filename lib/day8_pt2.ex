defmodule Day8Part2 do
  @moduledoc """
  """
  def calculate_value_of_root_node(input) do
    {node, _} =
      input
      |> String.split(" ")
      |> Day8Part1.parse_node()

    node
    |> find_node_value
  end

  def find_node_value(%Day8Node{children: [], metadata_values: metadata_values}) do
    Enum.sum(metadata_values)
  end

  def find_node_value(%Day8Node{children: children, metadata_values: metadata_values}) do
    metadata_values
    |> Enum.reduce(0, fn value, current_sum ->
      referenced_child = Enum.at(children, value - 1)

      if referenced_child == nil do
        current_sum
      else
        current_sum + find_node_value(referenced_child)
      end
    end)
  end
end
