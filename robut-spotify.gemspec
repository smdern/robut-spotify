# -*- encoding: utf-8 -*-
require File.expand_path('../lib/robut-spotify/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Shaun Dern"]
  gem.email         = ["shaun@substantial.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "robut-spotify"
  gem.require_paths = ["lib"]
  gem.version       = Robut::Spotify::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"

  gem.add_dependency "robot"
  gem.add_dependency "highline"
  gem.add_dependency "hallon"
  gem.add_dependency "sinatra"
end
