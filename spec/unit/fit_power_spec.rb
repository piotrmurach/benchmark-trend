# frozen_string_literal: true

RSpec.describe Benchmark::Trend, '#fit_power' do
  it 'calculates perfect power fit' do
    xs = [1, 2, 3, 4, 5]
    ys = xs.map { |x| 1.5 * (x ** 2) }

    a, b, rr = Benchmark::Trend.fit_power(xs, ys)

    expect(a).to be_within(0.001).of(2.0)
    expect(b).to be_within(0.001).of(1.5)
    expect(rr).to be_within(0.001).of(1.0)
  end

  it "calcualtes best power fit of y = x^1.5" do
    #    Mercury Venus Earth  Mars  Jupiter Saturn
    xs = [0.387, 0.723, 1.00, 1.524, 5.203,  9.539]  # distance from the sun
    ys = [0.241, 0.615, 1.00, 1.881, 11.862, 29.458] # period in Earth's years

    a, b, rr = Benchmark::Trend.fit_power(xs, ys)

    expect(a).to be_within(0.001).of(1.5)
    expect(b).to be_within(0.001).of(1.0)
    expect(rr).to be_within(0.001).of(0.999)
  end
end
