require_relative '../lib/benchmark-trend'

# linear
def fib_iter(n)
  a, b = 0, 1
  n.times { a, b = b, a + b}
  a
end

numbers = Benchmark::Trend.range(1, 20_000)
trend, trends = Benchmark::Trend.infer_trend(numbers) do |n|
  fib_iter(n)
end

puts "Trend: #{trend}"
puts "Trend data:"
pp trends
