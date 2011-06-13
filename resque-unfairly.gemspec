# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "resque/plugins/unfairly/version"

Gem::Specification.new do |s|
  s.name        = "resque-unfairly"
  s.version     = Resque::Plugins::Unfairly::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Evan Battaglia"]
  s.email       = ["evan@seomoz.org"]
  s.homepage    = ""
  s.summary     = %q{Order Resque queues probabilistically given a list of weights}
  s.description = %q{Usually Resque workers work on queues in the given order (if there is something in the first, work it, otherwise if the there is something in the second, work on it, and so on). This plugin randomizes the order of the queues based on weights, so that a given queue will be the first queue to try based on a probability weight. Given queues A, B, C, D and weights 4, 3, 2, 1, repsectively, A will be first 40% of the time, B 30%, C 20%, and D 10%. In addition, when B is first, A will be second 4/7ths of the time (4 / [4+2+1]), and so on. The project is inspired by resque-fairly, which unfortunately mathematically does not give you this control over the weights.}

  s.rubyforge_project = "resque-unfairly"

  s.add_runtime_dependency "resque", "~>1.0"
  s.add_development_dependency "rake", "~>0.8.7"
  s.add_development_dependency "rspec", ">=1.3.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
