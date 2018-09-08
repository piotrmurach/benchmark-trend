# frozen_string_literal: true

RSpec.describe Benchmark::Trend, '#range' do
  it "creates default range" do
    range = Benchmark::Trend.range(8, 8 << 10)
    expect(range).to eq([8, 64, 512, 4096, 8192])
  end

  it "creates range with 2 multiplier" do
    range = Benchmark::Trend.range(8, 8 << 10, ratio: 2)
    expect(range).to eq([8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192])
  end

  it "checks range start to be valid" do
    expect { 
      Benchmark::Trend.range(-2, 10_000)
    }.to raise_error(ArgumentError, "Range value: -2 needs to be greater than 0")
  end

  it "checks range end to be greater than start" do
    expect { 
      Benchmark::Trend.range(8, 2)
    }.to raise_error(ArgumentError, "Range value: 2 needs to be greater than 8")
  end

  it "checks multiplier to be valid" do
    expect { 
      Benchmark::Trend.range(8, 32, ratio: 1)
    }.to raise_error(ArgumentError, "Range value: 1 needs to be greater than 2")
  end
end
