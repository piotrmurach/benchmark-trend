# frozen_string_literal: true

RSpec.describe Benchmark::Trend, '#fit_log' do
  it "calculates perfect logarithmic fit" do
    xs = [1, 2, 3, 4, 5]
    ys = xs.map { |x|  1.5 * Math.log(x) + 1.0 }

    a, b, rr = Benchmark::Trend.fit_log(xs, ys)

    expect(a).to be_within(0.001).of(1.5)
    expect(b).to be_within(0.001).of(1.0)
    expect(rr).to be_within(0.001).of(1)
  end

  it "calculates logarithmic fit with noise" do
    # life expectancy in USA data from 1900 in 10 years periods
    xs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    ys = [47.3, 50.0, 54.1, 59.7, 62.9, 68.2, 69.7, 70.8, 73.7, 75.4, 76.8, 78.7]

    a, b, rr = Benchmark::Trend.fit_log(xs, ys)

    expect(a).to be_within(0.001).of(13.857)
    expect(b).to be_within(0.001).of(42.527)
    expect(rr).to be_within(0.001).of(0.956)
  end
end
