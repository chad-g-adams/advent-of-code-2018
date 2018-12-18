input = File.stream!('data/Day7')
answer = Day7Part2.total_time_to_execute(60, 5, input)
IO.puts(answer)