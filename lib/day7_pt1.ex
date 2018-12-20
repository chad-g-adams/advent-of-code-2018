defmodule Day7Part1 do
  @moduledoc """

    Day 7 Commentary:
      First part was OK, second part took a long time.
      First time my code worked for the test but didn't work for the full solution.
      (Turned out I read the challenge wrong.. was using wrong number of workers).

      Passing a lot of parameters around. Might be easier to pass state around as a
      single map structure than as individual parameters.
  """

  @doc """

  iex> Day7Part1.determine_order_to_execute([
  ...>  "Step C must be finished before step A can begin.",
  ...>  "Step C must be finished before step F can begin.",
  ...>  "Step A must be finished before step B can begin.",
  ...>  "Step A must be finished before step D can begin.",
  ...>  "Step B must be finished before step E can begin.",
  ...>  "Step D must be finished before step E can begin.",
  ...>  "Step F must be finished before step E can begin."
  ...>])
  "CABDFE"

  """
  def determine_order_to_execute(steps_input) do
    steps_input
    |> parse_dependencies
    |> determine_dependencies_for_each_step
    |> determine_execution_order
  end

  def parse_dependencies(steps_input) do
    steps_input
    |> Enum.map(fn s ->
      [_, dependency, step, _] =
        String.split(s, ["Step ", " must be finished before step ", " can begin."])

      {step, dependency}
    end)
  end

  def determine_dependencies_for_each_step(parsed_dependencies) do
    parsed_dependencies
    |> Enum.group_by(fn {step, _dependency} -> step end, fn {_step, dep} -> dep end)
  end

  def determine_execution_order(dependency_map) do
    awaiting_execution_map = MapSet.new(Map.keys(dependency_map))

    build_execution_order([], dependency_map, awaiting_execution_map)
    |> Enum.join()
  end

  defp build_execution_order(order, dependency_map, awaiting_execution_map) do
    {ready_steps, dependent_steps} =
      find_steps_that_are_ready_to_execute(dependency_map, awaiting_execution_map)

    next_step =
      ready_steps
      |> Enum.sort()
      |> Enum.at(0)

    case next_step do
      nil ->
        order |> Enum.reverse()

      _ ->
        updated_dependency_map =
          dependent_steps
          |> Enum.reduce(dependency_map, fn step, acc ->
            Map.update!(acc, step, fn value -> List.delete(value, next_step) end)
          end)
          |> Enum.into(%{})

        updated_dependency_map = Map.delete(updated_dependency_map, next_step)

        build_execution_order(
          [next_step | order],
          updated_dependency_map,
          Map.delete(awaiting_execution_map, next_step)
        )
    end
  end

  defp find_steps_that_are_ready_to_execute(dependency_map, awaiting_execution_map) do
    dependency_map
    |> Map.to_list()
    |> Enum.reduce({MapSet.new(), []}, fn {step, dependencies}, {ready_steps, dependent_steps} ->
      candidate_steps =
        find_steps_that_are_ready_to_execute_for_dependency(
          step,
          dependencies,
          awaiting_execution_map
        )

      {candidate_steps |> Enum.into(ready_steps), [step | dependent_steps]}
    end)
  end

  defp find_steps_that_are_ready_to_execute_for_dependency(
         step,
         _dependencies = [],
         _awaiting_execution_map
       ) do
    [step]
  end

  defp find_steps_that_are_ready_to_execute_for_dependency(
         _step,
         dependencies,
         awaiting_execution_map
       ) do
    dependencies
    |> Enum.filter(fn dependency -> dependency not in awaiting_execution_map end)
  end
end
