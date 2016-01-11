# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave/tinypng/version'

Gem::Specification.new do |spec|
  spec.name          = 'carrierwave-tinypng'
  spec.version       = CarrierWave::TinyPNG::VERSION
  spec.authors       = ['Yuichi Takeuchi', 'Tom Hoenderdos']
  spec.email         = ['uzuki05@takeyu-web.com', 'info@tompc.nl']
  spec.summary       = %q{TinyPNG support for CarrierWave}
  spec.description   = %q{TinyPNG support for CarrierWave}
  spec.homepage      = 'https://github.com/takeyuweb/carrierwave-tinypng'
  spec.license       = 'MIT'

  spec.files         =  Dir["{bin,lib}/**/*", "README.md"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'carrierwave'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'tinify'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'webmock'
end
