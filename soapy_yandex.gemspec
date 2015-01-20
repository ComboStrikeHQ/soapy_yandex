# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soapy_yandex/version'

Gem::Specification.new do |spec|
  spec.name          = 'soapy_yandex'
  spec.version       = SoapyYandex::VERSION
  spec.authors       = ['ad2games GmbH']
  spec.email         = ['developers@ad2games.com']
  spec.summary       = %q{Client library for Yandex Money.}
  spec.description   = %q{Client library for Yandex Money.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'ox', '~> 2.1'
  spec.add_runtime_dependency 'httparty', '~> 0.13'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-intercept'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'pry'
end
