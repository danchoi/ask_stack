# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
Gem::Specification.new do |s|
  s.name        = "ask_stack"
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.0'

  s.authors     = ["Daniel Choi"]
  s.email       = ["dhchoi@gmail.com"]
  s.homepage    = "https://github.com/danchoi/ask_stack"
  s.summary     = %q{Post questions to StackOverflow from the unix command line}
  s.description = %q{This project is alpha}

  s.rubyforge_project = "ask_stack"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'selenium-client', '>= 1.2.18' 
end
