defmodule Day7Part2Test do
  use ExUnit.Case
  doctest Day7Part2

  test "sample" do
    assert 15 ==
             Day7Part2.total_time_to_execute(
               0,
               2,
               [
                 "Step C must be finished before step A can begin.",
                 "Step C must be finished before step F can begin.",
                 "Step A must be finished before step B can begin.",
                 "Step A must be finished before step D can begin.",
                 "Step B must be finished before step E can begin.",
                 "Step D must be finished before step E can begin.",
                 "Step F must be finished before step E can begin."
               ]
             )
  end
end
