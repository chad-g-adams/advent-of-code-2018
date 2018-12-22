defmodule Day18Part2 do
  def get_resource_value_at_step_1_000_000_000(input) do
    initial_state = input |> Enum.map(&String.trim/1) |> Day18Part1.parse_input()

    {state, first_seen_minute, next_seen_minute} = find_cycle(initial_state)
    IO.inspect("Found a cycle! From step #{first_seen_minute} to step #{next_seen_minute}!")
    cycle_length = next_seen_minute - first_seen_minute

    additional_steps_to_run_to_hit_step_1_000_000_000 =
      rem(1_000_000_000 - next_seen_minute, cycle_length)

    %{trees: trees, lumberyard: lumberyards} =
      Stream.iterate(state, &Day18Part1.transition_state/1)
      |> Enum.at(additional_steps_to_run_to_hit_step_1_000_000_000)
      |> Day18Part1.count_types()

    trees * lumberyards
  end

  defp find_cycle(initial_state) do
    Stream.iterate({0, initial_state}, fn {minute, state} ->
      {minute + 1, Day18Part1.transition_state(state)}
    end)
    |> Enum.reduce_while(%{}, fn {minute, state}, acc ->
      if Map.get(acc, state) != nil do
        first_seen_minute = acc[state]
        {:halt, {state, first_seen_minute, minute}}
      else
        {:cont, Map.put(acc, state, minute)}
      end
    end)
  end
end
