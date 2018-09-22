# frozen_string_literal: true
#
RSpec.describe Benchmark::Trend, "#measure_execution_time" do
  it "measures performance times" do
    func = -> (x, i) { x ** 2 }

    data = Benchmark::Trend.measure_execution_time(&func)

    expect(data[0]).to eq([1, 8, 64, 512, 4096, 10000])
    expect(data[1]).to match([
      be_within(0.001).of(0.00001),
      be_within(0.001).of(0.00001),
      be_within(0.001).of(0.00001),
      be_within(0.001).of(0.00001),
      be_within(0.001).of(0.00001),
      be_within(0.001).of(0.00001)
    ])
  end
end
