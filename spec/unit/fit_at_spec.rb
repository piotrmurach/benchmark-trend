# frozen_string_literal: true

RSpec.describe Benchmark::Trend, '#fit_at' do
  it "evalutes logarithmic fit model at a given value" do
    val = Benchmark::Trend.fit_at(:logarithmic, slope: 1.5, intercept: 2, n: 10)

    expect(val).to be_within(0.1).of(5.45)
  end

  it "evalutes linear fit model at a given value" do
    val = Benchmark::Trend.fit_at(:linear, slope: 1.5, intercept: 2, n: 10)

    expect(val).to eq(17)
  end

  it "evalutes power fit model at a given value" do
    val = Benchmark::Trend.fit_at(:power, slope: 1.5, intercept: 2, n: 10)

    expect(val).to be_within(0.1).of(63.24)
  end

  it "evalutes power fit model at a given value" do
    val = Benchmark::Trend.fit_at(:exponential, slope: 1.5, intercept: 2, n: 10)

    expect(val).to be_within(0.1).of(115.33)
  end

  it "doesn't recognise fit model" do
    expect {
      Benchmark::Trend.fit_at(:unknown, slope: 1.5, intercept: 2, n: 10)
    }.to raise_error(ArgumentError, "Unknown fit type: unknown")
  end

  it "doesn't allow incorrect input size" do
    expect {
      Benchmark::Trend.fit_at(:linear, slope: 1.5, intercept: 2, n: -1)
    }.to raise_error(ArgumentError, "Incorrect input size: -1")
  end
end
