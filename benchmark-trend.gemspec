lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'benchmark/trend/version'

Gem::Specification.new do |spec|
  spec.name          = "benchmark-trend"
  spec.version       = Benchmark::Trend::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = [""]

  spec.summary       = %q{Measure pefromance trends of Ruby code based on the input size distribution.}
  spec.description   = %q{Benchmark::Trend will help you estimate the computational complexity of Ruby code by running it on inputs increasing in size, measuring their execution times, and then fitting these observations into a model that best predicts how a given Ruby code will scale as a function of growing workload.}
  spec.homepage      = "https://github.com/piotrmurach/benchmark-trend"
  spec.license       = "MIT"

  spec.files         = Dir['{lib,spec,examples}/**/*.rb']
  spec.files        += Dir['{bin,exe,tasks}/*', 'benchmark-trend.gemspec']
  spec.files        += Dir['README.md', 'CHANGELOG.md', 'LICENSE.txt', 'Rakefile']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
