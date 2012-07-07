# -*- encoding: utf-8 -*-
require File.expand_path('../lib/quincy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Levin Alexander"]
  gem.email         = ["mail@levinalex.net"]
  gem.description   = %q{}
  gem.summary       = %q{extract data from Frey Quincy PCNet data files or QuincyWin}
  gem.homepage      = "http://github.com/levinalex/quincy"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "quincy"
  gem.require_paths = ["lib"]
  gem.version       = Quincy::VERSION

  gem.add_dependency "rake"
  gem.add_development_dependency "rspec"
end

