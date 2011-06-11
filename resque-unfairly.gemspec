# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "resque-unfairly/version"

Gem::Specification.new do |s|
  s.name        = "resque-unfairly"
  s.version     = Resque::Unfairly::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Evan Battaglia"]
  s.email       = ["evan@seomoz.org"]
  s.homepage    = ""
  s.summary     = %q{Order Resque queues probabilistically given a list of weights}
  s.description = %q{Order Resque queues probabilistically given a list of weights}

  s.rubyforge_project = "resque-unfairly"

  s.add_development_dependency "rake", "~>0.8.7"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
