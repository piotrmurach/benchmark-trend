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

  it "calculates perfect constant fit" do
    xs = [1, 2, 3, 4, 5]
    ys = [6.0, 6.0, 6.0, 6.0, 6.0]

    a, b, rr = Benchmark::Trend.fit_linear(xs, ys)

    expect(a).to eq(0)
    expect(b).to eq(6)
    expect(rr).to eq(1)
  end

  it "calculates constant fit with noise" do
    xs = [1, 2, 3, 4, 5]
    ys = [1.0, 0.9, 1.0, 1.1, 1.0]

    a, b, rr = Benchmark::Trend.fit_linear(xs, ys)

    expect(a).to eq(0.02)
    expect(b).to be_within(0.01).of(0.94)
    expect(rr).to be_within(0.01).of(0.19)
  end

  it "raises when no variation in data" do
    xs = [1, 1, 1, 1, 1]
    ys = [1.0, 0.9, 1.0, 1.1, 1.0]

    expect {
      Benchmark::Trend.fit_linear(xs, ys)
    }.to raise_error(ArgumentError, "No variation in data [1, 1, 1, 1, 1]")
  end
end
