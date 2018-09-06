# Benchmark::Trend

[![Gem Version](https://badge.fury.io/rb/benchmark-trend.svg)][gem]
[![Build Status](https://secure.travis-ci.org/piotrmurach/benchmark-trend.svg?branch=master)][travis]
[![Build status](https://ci.appveyor.com/api/projects/status/2i5lx3tvyi5l8x3j?svg=true)][appveyor]
[![Maintainability](https://api.codeclimate.com/v1/badges/782faa4a8a4662c86792/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/piotrmurach/benchmark-trend/badge.svg)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/benchmark-trend.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/benchmark-trend
[travis]: http://travis-ci.org/piotrmurach/benchmark-trend
[appveyor]: https://ci.appveyor.com/project/piotrmurach/benchmark-trend
[codeclimate]: https://codeclimate.com/github/piotrmurach/benchmark-trend/maintainability
[coverage]: https://coveralls.io/r/piotrmurach/benchmark-trend
[inchpages]: http://inch-ci.org/github/piotrmurach/benchmark-trend

> Measure pefromance trends of Ruby code based on the input size distribution.

You can use **Benchmark::Trend** to estimate computational complexity by running Ruby code on inputs increasing in size, and measuring its execution times. Based on these measurements **Benchmark::Trend** will fit a model that best predicts how a given Ruby code will perform with growing load.

## Why?

Tests provide safety net that ensures your code works correctly. What you don't know is how fast your code is! How does it scale with different input sizes? Your code may have computational complexity that doens't scale with large workloads. It would be good to know before your application goes into production, wouldn't it?

**Benchmark::Trend** will allow you to uncover performance bugs or confirm that a Ruby code performance scales as expected.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'benchmark-trend'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install benchmark-trend

## Contents

* [1. Usage](#1-usage)
* [2. API](#2--api)
  * [2.1 range](#21-range)
  * [2.2 infer_trend](#22-infer_trend)

## 1. Usage

Let's assume we would like to find out behaviour of a Fibonnacci algorith:

```ruby
def fibonacci(n)
  n == 1 || n == 0 ? n : fibonacci(n - 1) + fibonacci(n - 2)
end
```

To measure the actual complexity of above function, we will use `infer_tren` method and pass it as a first argument an array of integer sizes and a block to execute the method:

```ruby
sizes = (1..24).to_a

trend, trends = Benchmark::Trend.infer_trend(sizes) do |n|
  fibonacci(n)
end
```

The return type will provide a best trend name:

```ruby
print trend
# => exponential
```

and a Hash of all the trend data:

```ruby
print trends
# =>
# {:exponential=>
#   {:trend=>"1.39 * 0.00^n",
#    :slope=>1.3861415449985763,
#    :intercept=>1.9181961296516025e-06,
#    :residual=>0.9165373086346811},
#  :power=>
#   {:trend=>"0.00n^2.27",
#    :slope=>6.356187983536552e-07,
#    :intercept=>2.2719141523851145,
#    :residual=>0.6120494462223005},
#  :linear=>
#   {:trend=>"0.00*n + -0.00",
#    :slope=>0.00026488137564940743,
#    :intercept=>-0.002015679028937629,
#    :residual=>0.44011069414646825},
#  :logarithmic=>
#   {:trend=>"0.00*ln(x) + -0.00",
#    :slope=>0.0015946924639701383,
#    :intercept=>-0.0023448616296455785,
#    :residual=>0.22003702102339448}}
```
## 2. API

### 2.1 range

### 2.2 infer_trend

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/benchmark-trend. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Benchmark::Trend project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/benchmark-trend/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2018 Piotr Murach. See LICENSE for further details.
