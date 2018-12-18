defmodule Day7Part2 do
  @moduledoc """
  """
  def total_time_to_execute(time_per_step, workers, steps_input) do
    with dependency_map <-
           steps_input
           |> Day7Part1.parse_dependencies()
           |> Day7Part1.determine_dependencies_for_each_step(),
         execution_order <-
           dependency_map
           |> Day7Part1.determine_execution_order()
           |> String.to_charlist() do
      run(dependency_map, -1, time_per_step, workers, %{}, execution_order)
    end
  end

  def run(_, current_time, _, _, work_assignments, _execution_order = [])
      when map_size(work_assignments) == 0 do
    current_time
  end

  def run(
        dependency_map,
        current_time,
        time_per_step,
        free_workers,
        work_assignments,
        execution_order
      ) do
    {newly_free_workers, work_assignments} = reduce_work_assignment_times(work_assignments)

    {work_assignments, free_workers, execution_order} =
      assign_work(
        dependency_map,
        time_per_step,
        free_workers + newly_free_workers,
        work_assignments,
        execution_order
      )

    run(
      dependency_map,
      current_time + 1,
      time_per_step,
      free_workers,
      work_assignments,
      execution_order
    )
  end

  defp reduce_work_assignment_times(work_assignments) when map_size(work_assignments) == 0 do
    {0, %{}}
  end

  defp reduce_work_assignment_times(work_assignments) do
    work_assignments
    |> Enum.reduce({0, work_assignments}, fn {step, time_left}, {newly_free_workers, acc} ->
      if time_left == 1 do
        {newly_free_workers + 1, Map.delete(acc, step)}
      else
        {newly_free_workers, Map.update!(acc, step, &(&1 - 1))}
      end
    end)
  end

  defp assign_work(_dependency_map, _time_per_job, free_workers, work_assignments, []) do
    {work_assignments, free_workers, []}
  end

  defp assign_work(_dependency_map, _time_per_job, 0, work_assignments, execution_order) do
    {work_assignments, 0, execution_order}
  end

  defp assign_work(
         dependency_map,
         time_per_job,
         free_workers,
         work_assignments,
         execution_order
       ) do
    next_ready_step =
      execution_order
      |> Enum.find(fn step ->
        is_step_ready?(dependency_map[<<step>>], work_assignments, execution_order)
      end)

    if next_ready_step != nil do
      assign_work(
        dependency_map,
        time_per_job,
        free_workers - 1,
        Map.put(work_assignments, next_ready_step, time_per_job + next_ready_step - 64),
        List.delete(execution_order, next_ready_step)
      )
    else
      {work_assignments, free_workers, execution_order}
    end
  end

  defp is_step_ready?(_dependencies = nil, _work_assignments, _execution_order) do
    true
  end

  defp is_step_ready?(dependencies, work_assignments, execution_order) do
    0 ==
      dependencies
      |> Enum.map(fn dep -> List.first(String.to_charlist(dep)) end)
      |> Enum.filter(fn dep -> Map.get(work_assignments, dep) != nil or dep in execution_order end)
      |> Enum.count()
  end
end
