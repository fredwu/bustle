# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bustle/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Fred Wu"]
  gem.email         = ["ifredwu@gmail.com"]
  gem.description   = %q{Activities recording and retrieving using a simple Pub/Sub architecture.}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/fredwu/bustle"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bustle"
  gem.require_paths = ["lib"]
  gem.version       = Bustle::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'minitest-colorize'
end
