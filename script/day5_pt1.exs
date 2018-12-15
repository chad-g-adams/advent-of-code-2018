input = String.to_charlist(File.read!('data/Day5'))
answer = Day5Part1.find_remaining_polymer_units(input)
IO.puts(answer)