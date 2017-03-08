# -*- encoding: utf-8 -*-

require File.expand_path('../lib/json2xxx/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "json2xxx"
  gem.version       = Json2xxx::VERSION
  gem.summary       = %q{json to variety of formats}
  gem.description   = %q{json to variety of formats}
  gem.license       = "MIT"
  gem.authors       = ["Hiroshi Toyama"]
  gem.email         = "toyama0919@gmail.com"
  gem.homepage      = "https://github.com/toyama0919/json2xxx"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'thor', '~> 0.19.1'
  gem.add_dependency 'spreadsheet'
  gem.add_dependency 'tbpgr_utils'
  gem.add_dependency 'hashie'
  gem.add_dependency 'awesome_print'

  gem.add_development_dependency 'bundler', '~> 1.7.2'
  gem.add_development_dependency 'pry', '~> 0.10.1'
  gem.add_development_dependency 'rake', '~> 10.3.2'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'rubocop', '~> 0.24.1'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'yard', '~> 0.8'
end
