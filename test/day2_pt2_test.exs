defmodule Day2Part2Test do
  use ExUnit.Case
  doctest Day2Part2

  test "sample" do
    assert 'abcde' ==
             Day2Part2.find_common_characters_for_words_one_char_apart('test/data/Day2test')
  end
end
