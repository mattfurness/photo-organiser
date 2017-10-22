# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'photo_organiser/version'

Gem::Specification.new do |spec|
  spec.name          = 'photo_organiser'
  spec.version       = PhotoOrganiser::VERSION
  spec.authors       = ['mattfurness']
  spec.email         = ['matthew.furness@everydayhero.com']

  spec.summary       = 'Organise photos by date'
  spec.description   = 'Organise photos by date filtering on EXIF info'
  spec.homepage      = 'https://github.com/mattfurness/photo-organiser'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'exifr', '~> 1.2.5'
  spec.add_dependency 'slop', '~> 4.4.1'
  spec.add_dependency 'parslet', '~> 1.7.1'
  spec.add_dependency 'filesize', '~> 0.1.1'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rubocop', '~> 0.44.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
