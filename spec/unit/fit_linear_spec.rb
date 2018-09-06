# frozen_string_literal: true

RSpec.describe Benchmark::Trend, '#fit_linear' do
  it "calculates perfect linear fit" do
    xs = [1, 2, 3, 4, 5]
    ys = xs.map { |x| 3.0 * x + 1.0 }

    a, b, rr = Benchmark::Trend.fit_linear(xs, ys)

    expect(a).to eq(3.0)
    expect(b).to eq(1.0)
    expect(rr).to be_within(0.1).of(1)
  end

  it "calculates linear fit with noise" do
    xs = [3.4, 3.8, 4.1, 2.2, 2.6, 2.9, 2.0, 2.7, 1.9, 3.4]
    ys = [5.5, 5.9, 6.5, 3.3, 3.6, 4.6, 2.9, 3.6, 3.1, 4.9]

    a, b, rr = Benchmark::Trend.fit_linear(xs, ys)

    expect(a).to be_within(0.1).of(1.64)
    expect(b).to be_within(0.1).of(-0.36)
    expect(rr).to be_within(0.001).of(0.953)
  end
end
