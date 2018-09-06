# frozen_string_literal: true

RSpec.describe Benchmark::Trend, '#fit_exp' do
  it "calculates a perfect exponential fit" do
    xs = [1, 2, 3, 4, 5]
    ys = xs.map { |x| 1.5 * (2 ** x) }

    a, b, rr = Benchmark::Trend.fit_exp(xs, ys)

    expect(a).to be_within(0.001).of(2.0)
    expect(b).to be_within(0.001).of(1.5)
    expect(rr).to be_within(0.001).of(0.999)
  end

  it "calculates best exponential fit of y = 1.30*(1.46)^x" do
    # the number y (in millions) of mobiles subscriberes from 1988 to 1997 USA
    xs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    ys = [1.6, 2.7, 4.4, 6.4, 8.9, 13.1, 19.3, 28.2, 38.2, 48.7]

    a, b, rr = Benchmark::Trend.fit_exp(xs, ys)

    expect(a).to be_within(0.001).of(1.458)
    expect(b).to be_within(0.001).of(1.300)
    expect(rr).to be_within(0.001).of(0.993)
  end
end
