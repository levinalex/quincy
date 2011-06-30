# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'quincy'

Gem::Specification.new do |s|
  s.name = %q{quincy}
  s.version = Quincy::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Levin Alexander"]
  s.description = %q{}
  s.email = %q{mail@levinalex.net}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.homepage = %q{http://github.com/levinalex/quincy}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = %q{extract patient data from QuincyPCnet data files, <http://www.frey.de/q_pcnet.htm>}

  s.add_dependency "rake"
  s.add_development_dependency "rspec"
end

