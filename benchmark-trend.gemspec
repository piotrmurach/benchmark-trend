require_relative "lib/benchmark/trend/version"

Gem::Specification.new do |spec|
  spec.name          = "benchmark-trend"
  spec.version       = Benchmark::Trend::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]

  spec.summary       = %q{Measure pefromance trends of Ruby code based on the input size distribution.}
  spec.description   = %q{Benchmark::Trend will help you estimate the computational complexity of Ruby code by running it on inputs increasing in size, measuring their execution times, and then fitting these observations into a model that best predicts how a given Ruby code will scale as a function of growing workload.}
  spec.homepage      = "https://github.com/piotrmurach/benchmark-trend"
  spec.license       = "MIT"
  if spec.respond_to?(:metadata=)
    spec.metadata = {
      "allowed_push_host" => "https://rubygems.org",
      "bug_tracker_uri"   => "https://github.com/piotrmurach/benchmark-trend/issues",
      "changelog_uri"     => "https://github.com/piotrmurach/benchmark-trend/CHANGELOG.md",
      "documentation_uri" => "https://www.rubydoc.info/gems/benchmark-trend",
      "homepage_uri"      => spec.homepage,
      "source_code_uri"   => "https://github.com/piotrmurach/benchmark-trend"
    }
  end

  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = ["README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.bindir        = "exe"
  spec.executables   = %w[bench-trend]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0.0"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
