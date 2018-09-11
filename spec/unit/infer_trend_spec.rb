# frozen_string_literal: true

RSpec.describe Benchmark::Trend, '#infer_trend' do
  # exponential
  def fibonacci(n)
    n == 1 || n == 0 ? n : fibonacci(n - 1) + fibonacci(n - 2)
  end

  # linear
  def fib_mem(n, acc = {"0" => 0, "1" => 1})
    return n if n < 2

    if !acc.key?(n.to_s)
      acc[n.to_s] = fib_mem(n - 1, acc) + fib_mem(n - 2, acc)
    end
    acc[n.to_s]
  end

  # linear
  def fib_iter(n)
    a, b = 0, 1
    n.times { a, b = b, a + b}
    a
  end

  # constant
  def fib_const(n)
    phi = (1 + Math.sqrt(5))/2
    (phi ** n / Math.sqrt(5)).round
  end

  it "infers fibonacci classic algorithm trend to be exponential" do
    numbers = Benchmark::Trend.range(1, 28, ratio: 2)
    trend, trends = Benchmark::Trend.infer_trend(numbers) do |n|
      fibonacci(n)
    end

    expect(trend).to eq(:exponential)
    expect(trends).to match(
      hash_including(:exponential, :power, :linear, :logarithmic))
    expect(trends[:exponential]).to match(
      hash_including(:trend, :slope, :intercept, :residual)
    )
  end

  it "infers fibonacci iterative algorithm trend to be linear" do
    numbers = Benchmark::Trend.range(1, 20_000)
    trend, _ = Benchmark::Trend.infer_trend(numbers) do |n|
      fib_iter(n)
    end

    expect(trend).to eq(:linear)
  end

  it "infers fibonacci constant algorithm trend to be linear" do
    numbers = Benchmark::Trend.range(1, 1000, ratio: 2)
    trend, trends = Benchmark::Trend.infer_trend(numbers) do |n|
      fib_const(n)
    end

    expect(trend).to eq(:logarithmic)
    expect(trends[trend][:slope]).to be_within(0.0001).of(0)
  end

  it "infers finding maximum value trend to be linear" do
    array_sizes = Benchmark::Trend.range(1, 100_000)
    number_arrays = array_sizes.map { |n| Array.new(n) { rand(n) } }.each

    trend, trends = Benchmark::Trend.infer_trend(array_sizes) do
      number_arrays.next.max
    end

    expect(trend).to eq(:linear)
    expect(trends[trend][:slope]).to be_within(0.0001).of(0)
  end

  it "infers binary search trend to be logarithmic" do
    array_sizes = Benchmark::Trend.range(1, 100_000)
    number_arrays = array_sizes.map { |n| Array.new(n) { rand(n) } }.each

    trend, _ = Benchmark::Trend.infer_trend(array_sizes) do |n|
      number_arrays.next.bsearch { |x| x > n/2 }
    end

    expect(trend).to eq(:logarithmic)
  end
end
