# frozen_string_literal: true

RSpec.describe Benchmark::Trend, '#infer_trend' do
  def fibonacci(n)
    n == 1 || n == 0 ? n : fibonacci(n - 1) + fibonacci(n - 2)
  end

  it "infers fibonacci algorithm trend to be exponential" do
    trend, trends = Benchmark::Trend.infer_trend(1..24) do |n|
      fibonacci(n)
    end

    expect(trend).to eq(:exponential)
    expect(trends).to match(
      hash_including(:exponential, :power, :linear, :logarithmic))
    expect(trends[:exponential]).to match(
      hash_including(:trend, :slope, :intercept, :residual)
    )
  end

  it "infers finding maximum value trend to be linear" do
    array_sizes = Benchmark::Trend.range(1, 100_000)
    number_arrays = array_sizes.map { |n| Array.new(n) { rand(n) } }.each

    trend, trends = Benchmark::Trend.infer_trend(array_sizes) do
      number_arrays.next.max
    end

    expect(trend).to eq(:linear)
    expect(trends).to match(
      hash_including(:exponential, :power, :linear, :logarithmic))
    expect(trends[:exponential]).to match(
      hash_including(:trend, :slope, :intercept, :residual)
    )
  end
end
