defmodule Day8Node do
  defstruct metadata_values: [], children: []
end

defmodule Day8Part1 do
  @moduledoc """

  Day 8 Commentary:
    Got bitten by elixir when doing efficient building a list by appending to the start
    but then forgetting to reverse list at the end (when order became important)!
    This caused some grief. I could have noticed this error sooner if I ran the tests more frequently
    during development.
  """

  def sum_metadata_entries(input) do
    {node, []} =
      input
      |> String.split(" ")
      |> parse_node

    node
    |> sum_tree_metadata
  end

  def parse_node([]) do
    {nil, []}
  end

  def parse_node([children | [metadata_entries | content]]) do
    children = String.to_integer(children)
    metadata_entries = String.to_integer(metadata_entries)

    {child_nodes, new_content} =
      case children do
        0 ->
          {[], content}

        _ ->
          Enum.reduce(1..children, {[], content}, fn _, {child_nodes, content} ->
            {node, new_content} = parse_node(content)

            case node do
              nil -> {child_nodes, new_content}
              _ -> {[node | child_nodes], new_content}
            end
          end)
      end

    metadata_values = new_content |> Enum.take(metadata_entries) |> Enum.map(&String.to_integer/1)
    new_content = new_content |> Enum.drop(metadata_entries)

    {
      %Day8Node{
        children: child_nodes |> Enum.reverse(),
        metadata_values: metadata_values
      },
      new_content
    }
  end

  def sum_tree_metadata(root) do
    children_sum =
      Enum.reduce(root.children, 0, fn child, current_sum ->
        current_sum + sum_tree_metadata(child)
      end)

    children_sum + Enum.sum(root.metadata_values)
  end
end
