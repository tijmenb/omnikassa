# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omnikassa/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tijmen"]
  gem.email         = ["tijmen@gmail.com"]
  gem.description   = %q{Gem for Omnikassa}
  gem.summary       = %q{Gem for Omnikassa}
  gem.homepage      = "https://github.com/tijmenb/omnikassa"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omnikassa"
  gem.require_paths = ["lib"]
  gem.version       = Omnikassa::VERSION

  gem.add_development_dependency "rspec"
end
