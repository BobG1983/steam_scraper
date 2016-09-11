# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steam_scraper/version'

Gem::Specification.new do |spec|
  spec.name          = 'steam_scraper'
  spec.version       = SteamScraper::VERSION
  spec.authors       = ['Robert Gardner']
  spec.email         = ['rantingbob@gmail.com']

  spec.summary       = 'Webscraper for the Steam Store'
  spec.description   = 'A webscraper that scrapes game data from store.steampowered.com'
  spec.homepage      = 'https://github.com/ShriekBob/steam_scraper'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'nokogiri', '~> 1.6.8'
  spec.add_development_dependency 'httparty', '~> 0.14.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6.8'
  spec.add_runtime_dependency 'httparty', '~> 0.14.0'
end
