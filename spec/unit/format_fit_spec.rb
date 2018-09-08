# frozen_string_literal: true

RSpec.describe Benchmark::Trend, '#format_fit' do
  it "returns a logarithmic template" do
    format = Benchmark::Trend.format_fit(:logarithmic)
    expect(format).to eq("%.2f + %.2f*ln(x)")
  end

  it "returns a linear template" do
    format = Benchmark::Trend.format_fit(:linear)
    expect(format).to eq("%.2f + %.2f*x")
  end

  it "returns a power template" do
    format = Benchmark::Trend.format_fit(:power)
    expect(format).to eq("%.2f * x^%.2f")
  end

  it "returns a exponential template" do
    format = Benchmark::Trend.format_fit(:exponential)
    expect(format).to eq("%.2f * %.2f^x")
  end

  it "fails to recognise fit type" do
    expect {
      Benchmark::Trend.format_fit(:unknown)
    }.to raise_error(ArgumentError, "Unknown type: 'unknown'")
  end
end
