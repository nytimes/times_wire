# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "times_wire/version"

Gem::Specification.new do |s|
  s.name        = "times_wire"
  s.version     = TimesWire::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Derek Willis"]
  s.email       = ["dwillis@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/times_wire"
  s.summary     = %q{A thin client for The New York Times Newswire API}
  s.description = %q{A Ruby library for parsing stories and blog posts from The New York Times Newswire API}

  s.rubyforge_project = "times_wire"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "shoulda"
end
