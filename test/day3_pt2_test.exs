defmodule Day3Part2Test do
  use ExUnit.Case
  doctest Day3Part2

  test "sample" do
    assert "3" == Day3Part2.claim_id_with_no_overlap('test/data/Day3test')
  end
end
