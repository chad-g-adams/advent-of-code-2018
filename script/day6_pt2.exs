input = File.stream!('data/Day6')
answer = Day6Part2.find_size_of_safe_region(input, 10_000)
IO.puts(answer)