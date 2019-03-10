require_relative '../lib/benchmark-trend'

def prime?(n)
  n != 1 && !(2..Math.sqrt(n).to_i).any? {|i| (n % i).zero? }
end

numbers = Benchmark::Trend.range(1, 100_000)
trend, trends = Benchmark::Trend.infer_trend(numbers, repeat: 10) do |n, i|
  prime?(n)
end

puts "Trend: #{trend}"
puts "Trend data:"
pp trends
