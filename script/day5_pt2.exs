input = String.to_charlist(File.read!('data/Day5'))
answer = Day5Part2.find_shortest_possible_polymer_units(input)
IO.puts(answer)