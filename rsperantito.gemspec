# encoding: UTF-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rsperantito/version'

Gem::Specification.new do |spec|
  spec.name           = %q{rsperantito}
  spec.version        = RSperantito::VERSION
  spec.authors        = ['Gerson Eufracio']
  spec.email          = ['gersoneufra@gmail.com']
  spec.summary        = %q{ruby client for the SPERANT API}
  spec.homepage       = 'http://rubygems.org/gems/rsperantito'
  spec.license        = 'MIT'

  spec.files          = `git ls-files -z`.split("\x0")
  spec.test_files     = spec.files.grep(/^spec\//)
  spec.require_paths  = ['lib']

  spec.add_dependency 'rest-client', '~> 2.0.2'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'vcr', '~> 3.0'

  spec.required_ruby_version = '>= 2.0.0'
end
