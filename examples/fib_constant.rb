require_relative '../lib/benchmark-trend'

# constant
def fib_const(n)
  phi = (1 + Math.sqrt(5))/2
  (phi ** n / Math.sqrt(5)).round
end

numbers = Benchmark::Trend.range(1, 1400, ratio: 2)
trend, trends = Benchmark::Trend.infer_trend(numbers, repeat: 100) do |n|
  fib_const(n)
end

puts "Trend: #{trend}"
puts "Trend data:"
pp trends
