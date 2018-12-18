defmodule Day7Part1Test do
  use ExUnit.Case
  doctest Day7Part1

  test "sample" do
    assert "CABDFE" ==
             Day7Part1.determine_order_to_execute([
               "Step C must be finished before step A can begin.",
               "Step C must be finished before step F can begin.",
               "Step A must be finished before step B can begin.",
               "Step A must be finished before step D can begin.",
               "Step B must be finished before step E can begin.",
               "Step D must be finished before step E can begin.",
               "Step F must be finished before step E can begin."
             ])
  end
end
